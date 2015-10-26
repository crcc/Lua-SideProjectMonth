-- graph datastructure
-- For now, let's just go with tagged nodes and edges, with some helper functions for 
-- forward and reverse traversal

local graph = {}
graph.__index = graph

function graph.create()
  local g = {
    nodes = {},
    forward = {},
    reverse = {}
  }
  setmetatable(g, graph)
  return g
end

function graph.vertex(self, node, tag)
  if not self.nodes[node] then
    self.nodes[node] = tag
  end
  return self
end

function graph.edge(self, left, right, tag)
  if type(left) ~= 'table' then left = {left, true} end
  if type(right) ~= 'table' then right = {right, true} end
  self:vertex(unpack(left))
  self:vertex(unpack(right))
  if not self.forward[left[1]] then self.forward[left[1]] = {} end
  if not self.forward[right[1]] then self.forward[right[1]] = {} end
  if not self.reverse[left[1]] then self.reverse[left[1]] = {} end
  if not self.reverse[right[1]] then self.reverse[right[1]] = {} end
  if tag == nil then tag = true end
  if not self.forward[left[1]][right[1]] then 
    self.forward[left[1]][right[1]] = tag
    self.reverse[right[1]][left[1]] = tag
  end
  return self
end

-- returns an iterator for each node, its actions, and a map of forward and reverse transitions
function graph.vertices(self)
  local node, tag = next(self.nodes, nil)
  return function()
    local forward = self.forward[node]
    local reverse = self.reverse[noode]
    local value = {node, tag, forward, reverse}
    node, tag = next(self.nodes, node)
    return table.unpack(value)
  end
end

local g = graph.create()
g:edge(1, 2)
for node, tag, forward, reverse in g:vertices() do
  print(node, tag, forward)
end

return graph