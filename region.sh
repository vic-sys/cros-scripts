#!BASH

flashrom --wp-disable
flashrom --wp-range 0 0

vpd -i RO_VPD -s region=us
