	radix decimal

Clock code
	global daylightSavingsTimeLookupTable

daylightSavingsTimeLookupTable:
	dw 0x1283 ; 2000 = 85 -> 301, 2001 = 83 -> 299
	dw 0x3151 ; 2002 = 89 -> 298, 2003 = 88 -> 297
	dw 0x23a5 ; 2004 = 87 -> 303, 2005 = 85 -> 301
	dw 0x0a03 ; 2006 = 84 -> 300, 2007 = 83 -> 299
	dw 0x3140 ; 2008 = 89 -> 298, 2009 = 87 -> 296
	dw 0x1b25 ; 2010 = 86 -> 302, 2011 = 85 -> 301
	dw 0x0a62 ; 2012 = 84 -> 300, 2013 = 89 -> 298
	dw 0x28c0 ; 2014 = 88 -> 297, 2015 = 87 -> 296
	dw 0x1b14 ; 2016 = 86 -> 302, 2017 = 84 -> 300
	dw 0x01e2 ; 2018 = 83 -> 299, 2019 = 89 -> 298
	dw 0x28b6 ; 2020 = 88 -> 297, 2021 = 86 -> 302
	dw 0x1294 ; 2022 = 85 -> 301, 2023 = 84 -> 300
	dw 0x39d1 ; 2024 = 90 -> 299, 2025 = 88 -> 297
	dw 0x2036 ; 2026 = 87 -> 296, 2027 = 86 -> 302
	dw 0x1283 ; 2028 = 85 -> 301, 2029 = 83 -> 299
	dw 0x3151 ; 2030 = 89 -> 298, 2031 = 88 -> 297
	dw 0x23a5 ; 2032 = 87 -> 303, 2033 = 85 -> 301
	dw 0x0a03 ; 2034 = 84 -> 300, 2035 = 83 -> 299
	dw 0x3140 ; 2036 = 89 -> 298, 2037 = 87 -> 296
	dw 0x1b25 ; 2038 = 86 -> 302, 2039 = 85 -> 301
	dw 0x0a62 ; 2040 = 84 -> 300, 2041 = 89 -> 298
	dw 0x28c0 ; 2042 = 88 -> 297, 2043 = 87 -> 296
	dw 0x1b14 ; 2044 = 86 -> 302, 2045 = 84 -> 300
	dw 0x01e2 ; 2046 = 83 -> 299, 2047 = 89 -> 298
	dw 0x28b6 ; 2048 = 88 -> 297, 2049 = 86 -> 302
	dw 0x1294 ; 2050 = 85 -> 301, 2051 = 84 -> 300
	dw 0x39d1 ; 2052 = 90 -> 299, 2053 = 88 -> 297
	dw 0x2036 ; 2054 = 87 -> 296, 2055 = 86 -> 302
	dw 0x1283 ; 2056 = 85 -> 301, 2057 = 83 -> 299
	dw 0x3151 ; 2058 = 89 -> 298, 2059 = 88 -> 297
	dw 0x23a5 ; 2060 = 87 -> 303, 2061 = 85 -> 301
	dw 0x0a03 ; 2062 = 84 -> 300, 2063 = 83 -> 299
	dw 0x3140 ; 2064 = 89 -> 298, 2065 = 87 -> 296
	dw 0x1b25 ; 2066 = 86 -> 302, 2067 = 85 -> 301
	dw 0x0a62 ; 2068 = 84 -> 300, 2069 = 89 -> 298
	dw 0x28c0 ; 2070 = 88 -> 297, 2071 = 87 -> 296
	dw 0x1b14 ; 2072 = 86 -> 302, 2073 = 84 -> 300
	dw 0x01e2 ; 2074 = 83 -> 299, 2075 = 89 -> 298
	dw 0x28b6 ; 2076 = 88 -> 297, 2077 = 86 -> 302
	dw 0x1294 ; 2078 = 85 -> 301, 2079 = 84 -> 300
	dw 0x39d1 ; 2080 = 90 -> 299, 2081 = 88 -> 297
	dw 0x2036 ; 2082 = 87 -> 296, 2083 = 86 -> 302
	dw 0x1283 ; 2084 = 85 -> 301, 2085 = 83 -> 299
	dw 0x3151 ; 2086 = 89 -> 298, 2087 = 88 -> 297
	dw 0x23a5 ; 2088 = 87 -> 303, 2089 = 85 -> 301
	dw 0x0a03 ; 2090 = 84 -> 300, 2091 = 83 -> 299
	dw 0x3140 ; 2092 = 89 -> 298, 2093 = 87 -> 296
	dw 0x1b25 ; 2094 = 86 -> 302, 2095 = 85 -> 301
	dw 0x0a62 ; 2096 = 84 -> 300, 2097 = 89 -> 298
	dw 0x28c0 ; 2098 = 88 -> 297, 2099 = 87 -> 296

	end
