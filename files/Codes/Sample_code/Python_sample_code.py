import pandas as pd
import numpy as np
from DataSdk import DataSdk
import os
from tqdm import tqdm
from pyecharts.charts import Line
import pyecharts.options as opts


# calculate four semi beta
def calc_realized_semibeta(data: pd.DataFrame):
    ## separate positive and negative index return
    f_pos = data[data['pct_chg_index'] >= 0]
    f_neg = data[data['pct_chg_index'] < 0]
    f_var = sum(data['pct_chg_index'] * data['pct_chg_index'])

    ## separate positive and negative individual stock return
    neg = f_neg[f_neg['pct_chg'] < 0]
    pos = f_pos[f_pos['pct_chg'] >= 0]
    m1 = f_pos[f_pos['pct_chg'] < 0]
    m2 = f_neg[f_neg['pct_chg'] >= 0]
    beta_n, beta_p, beta_m1, beta_m2 = 0, 0, 0, 0

    ## four semi beta
    if not neg.empty:
        beta_n = sum(neg['pct_chg'] * neg['pct_chg_index']) / f_var
    if not pos.empty:
        beta_p = sum(pos['pct_chg'] * pos['pct_chg_index']) / f_var
    if not m1.empty:
        beta_m1 = -sum(m1['pct_chg'] * m1['pct_chg_index']) / f_var
    if not m2.empty:
        beta_m2 = -sum(m2['pct_chg'] * m2['pct_chg_index']) / f_var

    return beta_n, beta_p, beta_m1, beta_m2


def calc_upside_downside(data: pd.DataFrame):
    ## upside and downside beta
    f_pos = data[data['pct_chg_index'] >= 0]
    f_neg = data[data['pct_chg_index'] < 0]

    beta_up, beta_down = 0, 0

    if not f_pos.empty:
        beta_up = sum(f_pos['pct_chg'] * f_pos['pct_chg_index']) / sum(f_pos['pct_chg_index'] * f_pos['pct_chg_index'])
    if not f_neg.empty:
        beta_down = sum(f_neg['pct_chg'] * f_neg['pct_chg_index']) / sum(
            f_neg['pct_chg_index'] * f_neg['pct_chg_index'])

    return beta_up, beta_down


def calc_skew_kurt(data: pd.DataFrame):
    ## coskew and cokurt
    m = len(data)
    r_mean, f_mean = data['pct_chg'].mean(), data['pct_chg_index'].mean()
    df_r, df_f = data['pct_chg'] - r_mean, data['pct_chg_index'] - f_mean
    csk = (1 / m * sum(df_r * df_f * df_f)) / (np.sqrt(1 / m * sum(df_r * df_r)) / m * sum(df_f * df_f))
    ckt = (1 / m * sum(df_r * df_f * df_f * df_f)) / (
                np.sqrt(1 / m * sum(df_r * df_r)) * (1 / m * sum(df_f * df_f)) ** (3 / 2))
    return csk, ckt


def rolling_realized_semibeta(window: int = 22, data: pd.DataFrame = None):
    ## rolling, sort by date first
    df = data.sort_values('trade_date', ascending=False).reset_index(drop=True)

    ## iterating date
    for i in tqdm(range(len(df) - window)):
        tmp = df.loc[i:i + window - 1]
        n, p, m1, m2 = calc_realized_semibeta(tmp)
        df.loc[i, 'beta_n'] = n
        df.loc[i, 'beta_p'] = p
        df.loc[i, 'beta_m1'] = m1
        df.loc[i, 'beta_m2'] = m2

        up, down = calc_upside_downside(tmp)
        df.loc[i, 'beta_up'] = up
        df.loc[i, 'beta_down'] = down

        csk, ckt = calc_skew_kurt(tmp)
        df.loc[i, 'csk'] = csk
        df.loc[i, 'ckt'] = ckt
    df.dropna(axis=0, how='any', inplace=True)
    return df


def plot_semibeta(data: pd.DataFrame, my_path='rb_figure'):
    code = data['ts_code'][0]
    line = Line()
    data.sort_values('trade_date', inplace=True)
    x_axis = [str(item) for item in data['trade_date']]
    beta = data['beta_n'] + data['beta_p'] + data['beta_m1'] + data['beta_m2']
    line.add_xaxis(x_axis)
    line.add_yaxis('beta N', data['beta_n'].values)
    line.add_yaxis('beta P', data['beta_p'].values)
    line.add_yaxis('beta M+', data['beta_m1'].values)
    line.add_yaxis('beta M-', data['beta_m2'].values)
    line.add_yaxis('beta', beta)
    line.set_series_opts(label_opts=opts.LabelOpts(is_show=False))
    line.render(my_path)


def semibeta(index_code: str, ts_code: str, window: int = 22, plotting=False, start_time: str = None,
             end_time: str = None):
    ds = DataSdk()
    df = ds.get_stock_daily(code=ts_code)[['trade_date', 'ts_code', 'pct_chg']]
    index_daily = ds.get_index_daily(code=index_code)[['trade_date', 'pct_chg']]
    df = pd.merge(df, index_daily, on='trade_date', suffixes=('', '_index'))
    res = rolling_realized_semibeta(data=df, window=window)
    if start_time:
        res = res[res['trade_date'] >= int(start_time)]
    if end_time:
        res = res[res['trade_date'] <= int(end_time)]
    res.to_csv('test_realized_beta.csv', index=False)
    if plotting:
        plot_semibeta(data=res, my_path=os.path.join('rb_figure', ts_code + '_' + str(window) + '.html'))
    return res


if __name__ == '__main__':
    ## first index, second individual stock
    df = semibeta('000016.SH', '600104.SH', 22, plotting=True, start_time='20200101')
