# Dummy fcntl for Windows to satisfy Home Assistant imports
LOCK_UN = 0
LOCK_SH = 1
LOCK_EX = 2
LOCK_NB = 4

def fcntl(fd, cmd, arg=0):
    return 0

def ioctl(fd, cmd, arg=0, mutate_flag=False):
    return 0

def flock(fd, operation):
    return 0

def lockf(fd, operation, length=0, start=0, whence=0):
    return 0
