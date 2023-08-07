module LogParser
  EntryKill = Struct.new(:id_killer, :id_killed)
  EntryPlayer = Struct.new(:id, :name)
end