edit demo /new
add node wave_1 /model=WaveDevice
add node wave_2 /model=WaveDevice
add node wave_3 /model=WaveDevice
add node wave_4 /model=WaveDevice
put wave_1:method """sine"""
put wave_2:method """cosine"""
put wave_3:method """triangle"""
put wave_4:method """square"""
put /extend wave_1:init_action
Action(Dispatch('dispatch_server','INIT',50,None),Method(None,'INIT',wave_1))

put /extend wave_2:init_action
Action(Dispatch('dispatch_server','INIT',50,None),Method(None,'INIT',wave_2))

put /extend wave_3:init_action
Action(Dispatch('dispatch_server','INIT',50,None),Method(None,'INIT',wave_3))

put /extend wave_4:init_action
Action(Dispatch('dispatch_server','INIT',50,None),Method(None,'INIT',wave_4))

put /extend wave_1:stop_action
Action(Dispatch('dispatch_server','STOP',50,None),Method(None,'STOP',wave_1))

put /extend wave_2:stop_action
Action(Dispatch('dispatch_server','STOP',50,None),Method(None,'STOP',wave_2))

put /extend wave_3:stop_action
Action(Dispatch('dispatch_server','STOP',50,None),Method(None,'STOP',wave_3))

put /extend wave_4:stop_action
Action(Dispatch('dispatch_server','STOP',50,None),Method(None,'STOP',wave_4))

write