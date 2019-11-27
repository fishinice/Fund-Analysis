global indexs="上证指数 深证成指 恒生指数 标普500 纳斯达克100 纳斯达克综指 纽约证交所综指 美国证交所综指 道琼斯工业平均"
*Fund Basic Info Import
import delim initial\0..txt, encoding("utf-8") clear
keep v1-v4
rename (v*) (date index_name pe pb)
destring pe, replace force

reshape wide pe pb, i(date) j(index_name) string

foreach index in $indexs{
foreach value in pb{
xtile tile_`value'_`index'= `value'`index', n(1000)
replace tile_`value'_`index'=tile_`value'_`index'/10
}
}

gen date_=date(date,"YMD")
rename (date date_) (date_ date)
format date %td


foreach index in $indexs{
foreach value in pb{
graph tw line tile_`value'_`index' date, ///
tlabel(1jan2009 1jan2011 1jan2013 1jan2015 1jan2017 1jan2019) ///
ylabel(0(10)100) yti("") ti(`index'——分位数)
gr export graph\g`index'_`value'.png, replace
}
}
