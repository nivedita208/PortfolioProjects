# COVID-19 Global Data Analysis (SQL)

## Overview
This project explores global COVID-19 case, death, and vaccination data using SQL Server. The goal was to derive meaningful insights — such as infection rates, death rates, and vaccination progress — from raw public health data, and to prepare a clean dataset/view for further visualization.

## Objectives
- Analyze the relationship between total COVID-19 cases and deaths by country
- Identify countries and continents with the highest infection and death rates relative to population
- Track global case and death trends over time
- Calculate rolling vaccination totals per country using window functions
- Create a reusable SQL View for downstream reporting/visualization tools (e.g., Tableau, Power BI, Excel)

## Dataset
Two tables were used:
- **CovidDeaths** — contains case counts, death counts, population, and location/date data
- **CovidVaccinations** — contains vaccination data by location and date

*(Source: publicly available COVID-19 dataset, commonly used for SQL portfolio practice — e.g., Our World in Data)*

## Key SQL Concepts Used
- Joins (combining CovidDeaths and CovidVaccinations)
- Aggregate functions (SUM, MAX)
- Window functions (`SUM() OVER (PARTITION BY ...)` for rolling totals)
- Common Table Expressions (CTEs)
- Temporary tables
- Views (for reusable, query-ready datasets)
- Data type casting (CAST)
- Calculated fields (percentages: death rate, infection rate, vaccination rate)

## Sample Insights Explored
- Likelihood of dying if infected with COVID-19, by country
- Percentage of a country's population infected
- Countries and continents with the highest infection and death counts
- Global total cases, deaths, and death percentage
- Rolling count of vaccinated people over time, by country



