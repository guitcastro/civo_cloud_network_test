# civo_cloud_network_test

Instance foo should be able to communicate to instance bar because they are in the same network, but this is not happening ...

### Output 

null_resource.test: Provisioning with 'remote-exec'...
null_resource.test (remote-exec): Connecting to remote host via SSH...
null_resource.test (remote-exec):   Host: 185.136.234.155
null_resource.test (remote-exec):   User: civo
null_resource.test (remote-exec):   Password: false
null_resource.test (remote-exec):   Private key: true
null_resource.test (remote-exec):   Certificate: false
null_resource.test (remote-exec):   SSH Agent: false
null_resource.test (remote-exec):   Checking Host Key: false
null_resource.test (remote-exec): Connected!
null_resource.test (remote-exec): PING 10.50.26.15 (10.50.26.15) 56(84) bytes of data.
null_resource.test (remote-exec): From 10.50.26.7 icmp_seq=1 Destination Host Unreachable
null_resource.test (remote-exec): From 10.50.26.7 icmp_seq=2 Destination Host Unreachable
null_resource.test (remote-exec): From 10.50.26.7 icmp_seq=3 Destination Host Unreachable
null_resource.test: Still creating... [10s elapsed]

### Notes
beside the test network another network is created: guilherme-castro-b080-guilherme-castro-b080-test_network-1bed6b4b-4dbf-488b-8add-3ea72563c61a-private-net
Using the default network the instance can communicate
