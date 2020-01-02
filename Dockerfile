FROM ros:melodic

WORKDIR /app
EXPOSE 5900

RUN apt-get update && apt-get install wget -y
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable xenial main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -

RUN apt-get update && apt-get install build-essential python3-pip python3-colcon-common-extensions cmake ros-melodic-tf ros-melodic-gazebo-ros-pkgs colcon-ros-bundle python3-apt -y
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

COPY simulation_ws simulation_ws
WORKDIR /app/simulation_ws
ENV ROS_DISTRO=melodic

RUN roslaunch training_grounds training_full_sim.launch
