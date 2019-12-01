
env_min=4
env_max=5
fer_min=5
fer_max=5

-- ^ rules

minetest.register_node("cells:cell",{
	description = "A cell",
	tiles = {"cells_cell.png"},
	is_ground_content = true,
	groups = {snappy = 1,fleshy = 1}
})

minetest.register_abm({
	nodenames = {"cells:cell"},
	interval = 1.0,
	action = function(pos,node,active_object_count,active_object_count_wider)
		local pos= {x=pos.x,y=pos.y,z=pos.z}
		local count=0
		local pos_arr,count_arr = minetest.find_nodes_in_area(vector.add(pos,-1),vector.add(pos,1),{"cells:cell"})
		count=count_arr["cells:cell"]
		if count<env_min or count>env_max then
			minetest.set_node(pos,{name="air"})
		end
	end
})

minetest.register_abm({
	nodenames = {"air"},
	neighbours = {"cells:cell"},
	interval = 1.0,
	action = function(pos,node,active_object_count,active_object_count_wider)
		local pos= {x=pos.x,y=pos.y,z=pos.z}
		local count=0
		local pos_arr,count_arr = minetest.find_nodes_in_area(vector.add(pos,-1),vector.add(pos,1),{"cells:cell"})
		count=count_arr["cells:cell"]
		if count>fer_min and count<fer_max then
			minetest.set_node(pos,{name="cells:cell"})
		end
	end
})
