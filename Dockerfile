FROM osrf/ros:noetic-desktop-full

# Set up environment
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
ENV QT_X11_NO_MITSHM=1
ENV DISPLAY=:0

# Install dependencies
RUN apt-get update && apt-get install -y \
    ros-noetic-joint-state-publisher-gui \
    ros-noetic-xacro \
    ros-noetic-gazebo-ros \
    ros-noetic-rosbridge-suite \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /root/catkin_ws
COPY . /root/catkin_ws/

# Source ROS
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

CMD ["bash"]
