import math
import time
import numpy as np
import matplotlib.pyplot as plt

fig=plt.figure(num=1,figsize=(6,4))
ax1=fig.add_subplot(2,2,1)
ax2=fig.add_subplot(2,2,2)
ax3=fig.add_subplot(2,2,3)
ax1.plot([1,2],[2,4])
plt.show(block=False)
plt.pause(0.5)
time.sleep(1)
plt.show()
