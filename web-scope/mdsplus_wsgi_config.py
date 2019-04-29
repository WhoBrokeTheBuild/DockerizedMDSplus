 import subprocess,os
 os.environ["UDP_EVENTS"]="yes"
 os.environ["MDS_PATH"]="/usr/local/mdsplus/tdi"
 os.environ["PATH"]="/usr/local/mdsplus/bin:"+os.environ["PATH"]
 os.environ["LD_LIBRARY_PATH"]="/usr/local/mdsplus/lib" 
 os.environ["mdsip_server_host"]=os.environ["SERVER"]
 # Get tree path environment variables configured in the MDSplus setup scripts 
 p=subprocess.Popen('. /usr/local/mdsplus/setup.sh; printenv | grep _path=',stdout=subprocess.PIPE,shell=True)
 s=p.wait()
 defs=p.stdout.read().split('\n')[:-1]
 p.stdout.close()
 for env in defs:
       ps=env.split('=')
       os.environ[ps[0]]=ps[1]