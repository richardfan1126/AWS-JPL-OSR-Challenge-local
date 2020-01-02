FROM ros:melodic

WORKDIR /app
EXPOSE 5900

RUN apt-get update && apt-get install wget -y
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable bionic main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -

RUN apt-get update && apt-get install -y build-essential python3-pip python3-colcon-common-extensions cmake ros-melodic-tf ros-melodic-gazebo-ros-pkgs python3-apt
RUN pip3 install -U colcon-ros-bundle boto3 colcon-common-extensions google
RUN pip3 install -U src/rl-agent/

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

COPY AWS-JPL-OSR-Challenge AWS-JPL-OSR-Challenge
WORKDIR /app/AWS-JPL-OSR-Challenge/simulation_ws
ENV ROS_DISTRO=melodic

RUN ["/bin/bash", "-c", "source /opt/ros/melodic/setup.bash; colcon build"]
RUN ["/bin/bash", "-c", "source /opt/ros/melodic/setup.bash; colcon bundle"]
