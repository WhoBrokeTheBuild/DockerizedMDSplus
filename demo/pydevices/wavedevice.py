import MDSplus
import time
import threading
import math
import numpy as np

class WAVEDEVICE(MDSplus.Device):
    """
    WaveDevice class for DAQ testing
    """

    parts = [
        {'path': ':COMMENT','type':'text','options':('no_write_shot',)},
        {'path': ':METHOD','type':'text','value':'sine','options':('no_write_shot',)},
        {'path': ':RUNNING','type':'numeric','options':('no_write_model',)},
        {'path': ':WAVE_DATA','type':'signal','options':('no_write_model','write_shot',)},
        {'path': ':MAX_SEGMENTS', 'type':'numeric','value':100,'options':('no_write_shot',)},
        {'path': ':SEG_LENGTH', 'type':'numeric','value':5,'options':('no_write_shot',)},
        {'path': ':STREAM_EVENT','type':'text','value':'WAVE_STREAM','options':('no_write_shot')},
        {'path': ':INIT_ACTION','type':'action','valueExpr':"Action(Dispatch('S','INIT',50,None),Method(None,'INIT',head))",'options':('no_write_shot',)},
        {'path': ':STOP_ACTION','type':'action','valueExpr':"Action(Dispatch('S','STOP',50,None),Method(None,'STOP',head))",'options':('no_write_shot',)},
    ]

    class Worker(threading.Thread):
        def __init__(self, dev):
            super(WAVEDEVICE.Worker,self).__init__(name=dev.path)
            self.dev = dev.copy()
        def run(self):
            self.dev.stream()

    def init(self):
        self.running.on = True
        thread = self.Worker(self)
        thread.start()
        return 1
    INIT=init
    
    def stop(self):
        self.running.on = False
        return 1
    STOP=stop

    def stream(self):
        event_name = self.stream_event.data()
        seg_length = int(self.seg_length.data())
        max_segments = self.max_segments.data()
        method = self.method.data()

        data = np.zeros(seg_length)
        times = np.zeros(seg_length)

        segment = 0
        start_time = time.time()
        previous_time = 0
        while self.running.on and segment < max_segments:
            sample = 0

            while self.running.on and sample < seg_length:
                previous_time = time.time()
                times[sample] = previous_time - start_time
                if method == "sine":
                    data[sample] = MDSplus.Float32(math.sin(times[sample]))
                elif method == "cosine":
                    data[sample] = MDSplus.Float32(math.cos(times[sample]))
                elif method == "triangle":
                    data[sample] = MDSplus.Float32(math.fmod(times[sample], 2))
                elif method == "square":
                    data[sample] = MDSplus.Float32(math.fabs(math.sin(times[sample]) + 1) / 2)

            if sample != seg_length - 1:
                times = times[0:sample]
                data = data[0:sample]
            
            segment += 1
            self.wave_data.makeSegment(times[0], times[-1], times, data)
            MDSplus.Event.setevent(event_name)
    STREAM=stream