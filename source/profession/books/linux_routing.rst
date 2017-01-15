**********************
Linux Advanced Routing
**********************


子网掩码决定了哪些网段的地址能够直接连上网卡，这个概念很重要。

.. code-block:: shell

	ip link list    # Show link list
	ip route show   # Show route table
	ip address show  # Show network address
	ip neigh show  # Show ARP cache table
	ip negith delete X.X.X.X dev eth  # delete a arp cache
	ip rule list # show all route table

multi ethnet split steps:
* create multi route tables and add default gateway
* 
* 