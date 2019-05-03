edit demo /new
add node wave_1 /model=WaveDevice
add node wave_2 /model=WaveDevice
add node wave_3 /model=WaveDevice
add node wave_4 /model=WaveDevice
put wave_1:wave_method """sine"""
put wave_2:wave_method """cosine"""
put wave_3:wave_method """triangle"""
put wave_4:wave_method """square"""
put wave_1:stream_event """WAVE_1_STREAM"""
put wave_2:stream_event """WAVE_2_STREAM"""
put wave_3:stream_event """WAVE_3_STREAM"""
put wave_4:stream_event """WAVE_4_STREAM"""
put /extend wave_1:init_action
BUILD_ACTION(BUILD_DISPATCH(2,'daq_server:8102','INIT',50,*),BUILD_METHOD(*,'INIT',wave_1))

put /extend wave_2:init_action
BUILD_ACTION(BUILD_DISPATCH(2,'daq_server:8102','INIT',50,*),BUILD_METHOD(*,'INIT',wave_2))

put /extend wave_3:init_action
BUILD_ACTION(BUILD_DISPATCH(2,'daq_server:8102','INIT',50,*),BUILD_METHOD(*,'INIT',wave_3))

put /extend wave_4:init_action
BUILD_ACTION(BUILD_DISPATCH(2,'daq_server:8102','INIT',50,*),BUILD_METHOD(*,'INIT',wave_4))

put /extend wave_1:stop_action
BUILD_ACTION(BUILD_DISPATCH(2,'daq_server:8102','STORE',50,*),BUILD_METHOD(*,'STOP',wave_1))

put /extend wave_2:stop_action
BUILD_ACTION(BUILD_DISPATCH(2,'daq_server:8102','STORE',50,*),BUILD_METHOD(*,'STOP',wave_2))

put /extend wave_3:stop_action
BUILD_ACTION(BUILD_DISPATCH(2,'daq_server:8102','STORE',50,*),BUILD_METHOD(*,'STOP',wave_3))

put /extend wave_4:stop_action
BUILD_ACTION(BUILD_DISPATCH(2,'daq_server:8102','STORE',50,*),BUILD_METHOD(*,'STOP',wave_4))

write