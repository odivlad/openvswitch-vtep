# What is it?
This repo contains stuff for running Open vSwitch-based VTEP emulator.

# What is VTEP?
VTEP - VXLAN Tunnel End Point. To provide L2 connectivity between VXLAN and VLAN
you can use VTEP.

# Why?
For testing and development of VTEP and SDN integrations.

# How to?

Install:

```
yum install openvswitch -y
git clone https://githib.com/odivlad/openvswitch-vtep.git
cd openvswitch-vtep
sudo cp ovs-vtepd.service /usr/lib/system/systemd/
sudo systemctl daemon-reload
```

Setup emulator:

1. Append VTEP database filename to OVS options and spawn new DB file with Hardware_Vtep OVS schema:
   ```
   echo 'OPTIONS=${OPTIONS} --extra-dbs=hw_vtep.db' >> /etc/sysconfig/openvswitch
   ovsdb-tool create /etc/openvswitch/hw_vtep.db /usr/share/openvswitch/vtep.ovsschema
   ```

2. Start openvswitch
   ```
   systemctl start openvswitch
   ```

3. Create OVS bridge and OVS port for outgoing VTEP traffic in it:
   ```
   ovs-vsctl add-br vtep-br
   ovs-vsctl add-port vtep-br eth1
   ```

4. Configure VTEP DB:
   ```
   vtep-ctl add-ps br0
   vtep-ctl set Physical_Switch br0 tunnel_ips=<your VXLAN IP>
   [optional] vtep-ctl set-manager tcp:<controller_ip>:<controller_port>
   ```

5. Start VTEP emulator:
   ```
   echo "VTEP_SWITCH_NAME=br0" >> /etc/sysconfig/openvswitch-vtep
   systemctl start ovs-vtepd
   ```
