
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
		for x=pos.x-1,pos.x+1 do
			for y=pos.y-1,pos.y+1 do
				for z=pos.z-1,pos.z+1 do
					if not( x==pos.x and y==pos.y and z==pos.z) then
						local node=minetest.get_node({x,y,z})
						if node.name=="cells:cell" then
							count=count+1
						end
					end	
				end
			end
		end
		if count<env_min or count>env_max then
			minetest.remove_node(pos)
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
		for x=pos.x-1,pos.x+1 do
			for y=pos.y-1,pos.y+1 do
				for z=pos.z-1,pos.z+1 do
					if not( x==pos.x and y==pos.y and z==pos.z) then
						local node=minetest.get_node({x,y,z})
						if node.name=="cells:cell" then
							count=count+1
						end
					end	
				end
			end
		end
		if count>fer_min and count<fer_max then
			minetest.set_node(pos,{name="cells:cell"})
		end
	end
})
