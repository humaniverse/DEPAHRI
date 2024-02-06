# DEPAHRI

## Overview
The Digital Exclusion and Physical Access to Healthcare Risk Index (DEPAHRI) is a dataset that indicates the overall difficulty of physically and digitally accessing healthcare services in England, Wales and Scotland. It builds on the [DERI Index](https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/tree/main), adding a physical component to it.

Higher DEPAHRI scores indicate higher risk of exclusion to healthcare services.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("humaniverse/DEPAHRI")
```

## Methodology
DEPAHRI is made up of four equally weighted components. Each component is based on a set of indicators:
- Demography
    - Population aged 65+
    - Population aged 75+
    - Residents whose daily acitivites are limited
    - Population in social grade DE
- Deprivation
    - Residents on guaranteed Pension Credit
    - Population 16+ without qualifications
    - Alternative unemployment rate
    - Index of Multiple Deprivation score
- Digital connectivity
    - Homes unable to receive 30MBit/s connection
    - Connections receiving less than 10MBit/s
    - Download speed
- Physical access to healthcare
    - Road distance to GP surgery
    - Road distance to nearest three hospitals

Each indicator is scaled from 0 to 10 and based on the national minumum and maximum values.

Deprivation, demography and digital connectivity make up the DERI Index. DEPAHRI is the addition of a physical access component.


