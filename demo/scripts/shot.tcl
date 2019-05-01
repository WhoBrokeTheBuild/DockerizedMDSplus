set verify
set tree demo
set current demo /increment
create pulse 0
set tree demo /shot=0
dispatch /build /monitor=DEMO_MONITOR
dispatch /phase init /monitor=DEMO_MONITOR
