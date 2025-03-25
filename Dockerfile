# Use the official ROS Noetic image as a base image
FROM ros:noetic

# Install dependencies for Gazebo, ROS Noetic, and the necessary tools
RUN apt-get update && apt-get install -y \
  git \
  build-essential \
  cmake \
  python3-catkin-tools \
  python3-pip \
  libgazebo11-dev \
  gazebo11 \
  ros-noetic-gazebo-ros \
  ros-noetic-urdf \
  ros-noetic-rviz \
  ros-noetic-joint-state-publisher \
  ros-noetic-robot-state-publisher \
  ros-noetic-gazebo-ros-pkgs \
  ros-noetic-controller-manager \
  ros-noetic-ros-control \
  ros-noetic-ros-controllers \
  ros-noetic-xacro \
  ros-noetic-rviz \
  && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Clone the BellPepper Gripper Prototype repository
RUN git clone https://github.com/AbhishekMathur11/BellPepperGripperPrototype.git

# Build the catkin workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; cd BellPepperGripperPrototype; catkin_make"

# Source ROS Noetic setup and build the workspace
RUN echo "source /root/BellPepperGripperPrototype/devel/setup.bash" >> ~/.bashrc

# Set up the entry point to run ROS commands
ENTRYPOINT ["/bin/bash", "-c", "source /root/BellPepperGripperPrototype/devel/setup.bash; roslaunch BellPepperGripperPrototype gripper.launch"]
