#! /bin/bash

echo "S3_ENDPOINT_URL=http://$(hostname -I | cut -d' ' -f1):9000" >> ~/AWS-JPL-OSR-Challenge-local/robomaker.env
docker run --rm --name dr --env-file ./robomaker.env -v $(pwd)/AWS-JPL-OSR-Challenge/simulation_ws/src/rl-agent/markov:/app/AWS-JPL-OSR-Challenge/simulation_ws/install/markov/lib/python3.6/site-packages/markov -v $(pwd)/log:/root/.ros -p 8080:5900 -it richardfan1126/aws-jpl-osr:local_v1.0 "./run.sh train mars mars_full_sim.launch"
