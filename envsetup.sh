# define all of your libs here -- should be a CSV file for each lib
GPLMLIBS="ana cap cpd dio ics ind mpu pot pwr rfm res reg xtr osc opt art"

parts_db_create() {
	rm parts.sqlite

	for lib in ${GPLMLIBS}; do
		sqlite3 --csv ./parts.sqlite ".import ${lib}.csv ${lib}" || return 1
	done
}

parts_db_edit() {
	sqlitebrowser parts.sqlite
}
