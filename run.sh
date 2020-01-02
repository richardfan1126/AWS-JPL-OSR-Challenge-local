export XAUTHORITY=/root/.Xauthority
source /opt/ros/melodic/setup.bash

if [ "$1" == "build" ]; then
	rm -R build
	rm -R install
	colcon build
  colcon bundle
elif [ "$1" == "train" ]; then
  source install/setup.sh
  if which x11vnc &>/dev/null; then
  	export DISPLAY=:0
  	xvfb-run -f $XAUTHORITY -l -n 0 -s ":0 -screen 0 1400x900x24" jwm &
  	x11vnc -bg -forever -nopw -rfbport 5900 -display WAIT$DISPLAY &
  	roslaunch training_grounds $2 &
  	rqt &
  	rviz &
  fi

  sleep 1

  echo "IP: $(hostname -I) ($(hostname))"
  wait
fi
