# define all of your libs here -- should be a CSV file for each lib
GPLMLIBS="cap res pot switch ics mcu amp ldo pwr bjt fet diode zener xtal tvs opto conn"

parts_db_create() {
	rm parts.sqlite

	for lib in ${GPLMLIBS}; do
		sqlite3 --csv ./parts.sqlite ".import ${lib}.csv ${lib}" || return 1
	done
}

pull_libs() {
	for lib in ${GPLMLIBS}; do
		wget -O "${lib}.csv" "https://docs.google.com/spreadsheets/d/$1/gviz/tq?tqx=out:csv&sheet=${lib}"
	done
}

parts_db_edit() {
	sqlitebrowser parts.sqlite
}
