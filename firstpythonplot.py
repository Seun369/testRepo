import matplotlib.pyplot as plt

x = [4.445, -0.654, 6.068, 5.670, 6.160, 6.177, -1.766, 7.617, -8.176, 4.105]
y = [-0.454, 0.565, -4.566, 6.007, 0.116,-6.716, 6.716, -7.613, 3.132, 0.497]
z = [0.465, 0.265, -5.711, 6.176, -1.223, 5.746, 7.897, 3.477, 1.256, -2.334]

fig = plt.figure()
axis = fig.add_subplot(projection='3d')

axis.set_xlabel('X Label')
axis.set_ylabel('Y Label')
axis.set_zlabel('Z Label')
       
axis.scatter(x,y,z)
plt.show()
