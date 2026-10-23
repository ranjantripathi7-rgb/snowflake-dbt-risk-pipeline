-- Run using SYSADMIN after the required permissions are granted.
use role SYSADMIN;

-- Compute resources for loading data and running queries.
create warehouse if not exists TRAINING_WH
    warehouse_size = 'XSMALL'
    auto_suspend = 60
    auto_resume = true
    initially_suspended = true;

-- Project database and schemas.
create database if not exists RISK_DEMO;

create schema if not exists RISK_DEMO.RAW;
create schema if not exists RISK_DEMO.ANALYTICS;

use warehouse TRAINING_WH;
use database RISK_DEMO;
use schema RAW;

-- Preserve incoming source values as text.
create table if not exists RISK_DEMO.RAW.LOANS (
    loan_id          varchar,
    customer_id      varchar,
    portfolio        varchar,
    reporting_date   varchar,
    currency         varchar,
    exposure_amount  varchar,
    pd               varchar,
    lgd              varchar,
    updated_at       varchar,
    loaded_at        timestamp_ntz default current_timestamp()
);

-- Instructions for reading source CSV files.
create file format if not exists RISK_DEMO.RAW.LOAN_CSV_FORMAT
    type = CSV
    skip_header = 1
    field_optionally_enclosed_by = '"'
    empty_field_as_null = true
    error_on_column_count_mismatch = true;

-- File storage location before loading rows into the table.
create stage if not exists RISK_DEMO.RAW.LOAN_STAGE
    file_format = RISK_DEMO.RAW.LOAN_CSV_FORMAT;
