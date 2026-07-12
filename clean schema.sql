USE india_financial_stress;

-- Drop all tables clean start
DROP TABLE IF EXISTS ml_predictions;
DROP TABLE IF EXISTS zscore_results;
DROP TABLE IF EXISTS stock_prices;
DROP TABLE IF EXISTS financial_data;
DROP TABLE IF EXISTS macro_indicators;
DROP TABLE IF EXISTS companies;

-- TABLE 1: COMPANIES
CREATE TABLE companies (
    company_id     INT AUTO_INCREMENT PRIMARY KEY,
    ticker         VARCHAR(20) NOT NULL UNIQUE,
    company_name   VARCHAR(100) NOT NULL,
    sector         VARCHAR(50) NOT NULL,
    industry       VARCHAR(50),
    nse_symbol     VARCHAR(20),
    market_cap_cr  DECIMAL(15,2),
    current_price  DECIMAL(10,2),
    face_value     DECIMAL(5,2),
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE 2: FINANCIAL DATA
CREATE TABLE financial_data (
    financial_id       INT AUTO_INCREMENT PRIMARY KEY,
    ticker             VARCHAR(20) NOT NULL,
    report_year        INT NOT NULL,
    report_date        DATE,
    revenue            DECIMAL(15,2),
    other_income       DECIMAL(15,2),
    employee_cost      DECIMAL(15,2),
    other_expenses     DECIMAL(15,2),
    depreciation       DECIMAL(15,2),
    interest_expense   DECIMAL(15,2),
    profit_before_tax  DECIMAL(15,2),
    tax_amount         DECIMAL(15,2),
    net_profit         DECIMAL(15,2),
    equity_capital     DECIMAL(15,2),
    reserves           DECIMAL(15,2),
    total_borrowings   DECIMAL(15,2),
    other_liabilities  DECIMAL(15,2),
    total_assets       DECIMAL(15,2),
    net_block          DECIMAL(15,2),
    investments        DECIMAL(15,2),
    cash_and_bank      DECIMAL(15,2),
    other_assets       DECIMAL(15,2),
    num_equity_shares  DECIMAL(20,2),
    cfo                DECIMAL(15,2),
    cfi                DECIMAL(15,2),
    cff                DECIMAL(15,2),
    net_cash_flow      DECIMAL(15,2),
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_ticker_year (ticker, report_year),
    FOREIGN KEY (ticker) REFERENCES companies(ticker)
);

-- TABLE 3: STOCK PRICES
CREATE TABLE stock_prices (
    price_id      INT AUTO_INCREMENT PRIMARY KEY,
    ticker        VARCHAR(20) NOT NULL,
    price_date    DATE NOT NULL,
    open_price    DECIMAL(10,2),
    high_price    DECIMAL(10,2),
    low_price     DECIMAL(10,2),
    close_price   DECIMAL(10,2),
    vol           BIGINT,
    market_cap_cr DECIMAL(15,2),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_ticker_date (ticker, price_date),
    FOREIGN KEY (ticker) REFERENCES companies(ticker)
);

-- TABLE 4: MACRO INDICATORS
CREATE TABLE macro_indicators (
    macro_id          INT AUTO_INCREMENT PRIMARY KEY,
    period_key        VARCHAR(7) NOT NULL UNIQUE,
    macro_year        INT NOT NULL,
    macro_month       INT NOT NULL,
    repo_rate         DECIMAL(5,2),
    rev_repo_rate     DECIMAL(5,2),
    cpi_inflation     DECIMAL(5,2),
    gdp_growth        DECIMAL(5,2),
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE 5: ZSCORE RESULTS
CREATE TABLE zscore_results (
    zscore_id     INT AUTO_INCREMENT PRIMARY KEY,
    ticker        VARCHAR(20) NOT NULL,
    report_year   INT NOT NULL,
    x1_wc_ratio   DECIMAL(10,4),
    x2_re_ratio   DECIMAL(10,4),
    x3_ebit_ratio DECIMAL(10,4),
    x4_mktcap_ratio DECIMAL(10,4),
    x5_rev_ratio  DECIMAL(10,4),
    z_score       DECIMAL(10,4),
    risk_zone     VARCHAR(10) NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_ticker_year (ticker, report_year),
    FOREIGN KEY (ticker) REFERENCES companies(ticker)
);

-- TABLE 6: ML PREDICTIONS
CREATE TABLE ml_predictions (
    prediction_id   INT AUTO_INCREMENT PRIMARY KEY,
    ticker          VARCHAR(20) NOT NULL,
    pred_year       INT NOT NULL,
    input_zscore    DECIMAL(10,4),
    input_de_ratio  DECIMAL(10,4),
    input_roe       DECIMAL(10,4),
    input_curr_ratio DECIMAL(10,4),
    input_repo      DECIMAL(5,2),
    input_cpi       DECIMAL(5,2),
    predicted_risk  VARCHAR(10) NOT NULL,
    prob_safe       DECIMAL(5,4),
    prob_grey       DECIMAL(5,4),
    prob_distress   DECIMAL(5,4),
    confidence_pct  DECIMAL(5,4),
    actual_risk     VARCHAR(10),
    is_correct      TINYINT(1),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_ticker_year (ticker, pred_year),
    FOREIGN KEY (ticker) REFERENCES companies(ticker)
);

SHOW TABLES;