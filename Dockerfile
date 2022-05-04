ARG ROS_DISTRO=melodic

FROM ros:$ROS_DISTRO
LABEL description="uavcan_msgs"
LABEL maintainer="ponomarevda96@gmail.com"
SHELL ["/bin/bash", "-c"]
WORKDIR /catkin_ws/src/uavcan_msgs
RUN apt-get update                          &&  \
    apt-get upgrade -y                      &&  \
    apt-get install -y  git ros-$ROS_DISTRO-catkin python3-catkin-tools
RUN if [[ "$ROS_DISTRO" = "melodic" ]] ; then apt-get install -y python-pip python-catkin-tools ; fi

COPY msg/               msg/
COPY ["CMakeLists.txt", "package.xml", "./"]

RUN source /opt/ros/$ROS_DISTRO/setup.bash  && cd ../../ && catkin build

CMD echo "main process has been started"            &&  \
    echo "container has been finished"
