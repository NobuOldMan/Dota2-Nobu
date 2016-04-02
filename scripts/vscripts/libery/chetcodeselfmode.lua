	print("@@@ : Cheats.lua Init ")

--------------------------------------------------------------------------------
--                                    測試                                    --
--------------------------------------------------------------------------------
if Ctest == nil then
    Ctest = class({})
end

function Ctest:OnNPCSpawned(info)
end

function Pick_Hero(info)
  print("@@@@ : Pick Hero Init")
  DeepPrintTable(info)    --详细打印传递进来的表
end



function Chat(info)
  print("@@@@ : Chat Init")
  DeepPrintTable(info)    --详细打印传递进来的表

--測試創造單位
--local id    = info.player --BUG:在講話事件裡，讀取不到玩家，是整數。
local s   	   = info.text	
local id  	   = info.userid --BUG:會1.2的調換，不知道為甚麼
local p 	     = PlayerResource:GetPlayer(id-1)--可以用索引轉換玩家方式，來捕捉玩家
local hero 	   = p: GetAssignedHero()

	if s == "creat" then
		u2 = CreateUnitByName("npc_jidi",Vector(0,-1200),true,nil,nil,0)
	end	

	if s == "change" then
	end

	if s == "show player" then
		UTIL_MessageTextAll(PlayerResource:GetPlayerName(1),255,0,0,255)
		UTIL_MessageTextAll(tostring(id),255,0,0,255)

			if p == nil then
				UTIL_MessageTextAll("nil",255,0,0,255)--BUG點:不能發nil，要"nil"要不然會崩潰
			end
	end

	if s == "creat lina" then--實驗句柄獲取
	    local lina = {}
 		for n=1,5 do
        	lina[n] = CreateUnitByName("npc_dota_hero_lina",Vector(0,0),true,nil,nil,2)
        	UTIL_MessageTextAll(tostring(lina[n]:entindex()),255,0,0,255)
     	end
	end

	if s == "show class name" then--顯示句柄名子
       local name = hero: GetClassname()
       UTIL_MessageTextAll(name,0,255,0,255)--具有自動調節語言能力
	end


	if s == "creat item" then
		item = CreateItem("item_blink",nil,nil)
		CreateItemOnPositionSync(Vector(5,5), item)
	end

	if s == "revome item" then
		hero:RemoveItem(item)
		--item: Destroy() --無法刪除地面上的道具
	end

	if s == "spell ability" then
		-- local spell = hero: FindAbilityByName("sven_warcry_datadriven")
		-- UTIL_MessageTextAll(tostring(spell),0,255,0,255)
		-- hero: CastAbilityImmediately(spell,0)

		--another test
		local u3 = CreateUnitByName("npc_dota_hero_lion",Vector(0,0),true,nil,nil,2)
		--u3:AddAbility("sven_ability3")w
		local spell = u3: FindAbilityByName("sven_ability3")
		UTIL_MessageTextAll(tostring(spell),0,255,0,255)
		u3: CastAbilityImmediately(spell,0)--可以無視有沒有學習，直接使用技能

	end

	if s == "spell to position" then
		local spell = hero: FindAbilityByName("earthshaker_fissure")--必須要技能等級>0
		UTIL_MessageTextAll(tostring(spell),0,255,0,255)
		hero: CastAbilityOnPosition(Vector(0,0),spell,0)
	end

	if s == "spell to target" then
		local spell = hero: FindAbilityByName("lina_ability2")--必須要技能等級>0
		UTIL_MessageTextAll(tostring(spell),0,255,0,255)
		hero:CastAbilityOnTarget(u2,spell,0)
	end

	if s == "ability toggle" then
		local spell = hero: FindAbilityByName("pudge_rot")--必須要技能等級>0
		UTIL_MessageTextAll(tostring(spell),0,255,0,255)
		hero: CastAbilityToggle(spell,0)
	end

	if s == "level up" then
		for i=1,25 do
			hero.HeroLevelUp(hero,true)
		end
    UTIL_MessageTextAll(tostring(hero),0,255,0,255)
	end

  if s ==  "disassemble" then
    local item = hero: AddItemByName("item_arcane_boots")
    hero: DisassembleItem(item)
    UTIL_MessageTextAll(tostring(item),0,255,0,255)  
  end

  if s == "drop item" then
    local item = hero: AddItemByName("item_heart")
    local pos = hero: GetOrigin() + RandomVector(300)
    hero: DropItemAtPosition(pos,item)
  end

  if s == "drop item immediate" then
    local item = hero: AddItemByName("item_heart")
    local pos = hero: GetOrigin() + RandomVector(300)
    hero: DropItemAtPositionImmediate(item,pos)
  end

  if s == "force kill unit" then
    hero:ForceKill(true)
    hero: SetThink(
    function ()    --2秒后复活
      hero: RespawnUnit()--BUG:DOTA內建復活時間倒數完，還是會調換回去。
    end,2.0)
  end

  if s == "get ability count" then
    local count = hero: GetAbilityCount()
    UTIL_MessageTextAll(tostring(count),0,255,0,255)--為甚麼有17個技能...
  end

  if s == "acquisitionRange" then
    local range = hero: GetAcquisitionRange()
    print("rang1: "..range)
    hero: SetAcquisitionRange(200)
    range = hero: GetAcquisitionRange()
    print("rang2: "..range)
  end

  if s == "GetAttackAnimationPoint" then
  	local point = hero: GetAttackAnimationPoint()
  	UTIL_MessageTextAll(tostring(point),0,255,0,255)
  end

  if s == "left" or s == "right" then --研究path.carner
    local ent = Entities:FindByName(nil,s)
    UTIL_MessageTextAll("@@@@ "..tostring(ent),0,255,255,255)  
    print("@@@@ "..tostring(ent))

    u2 = CreateUnitByName("npc_jidi",ent:GetAbsOrigin(),true,nil,nil,0)
    print("@@@@ "..tostring(u2))
  end

  if s == "Create Unit to attack1" then
    ShuaGuai2 = CreateUnitByName("npc_dota_neutral_alpha_wolf",Vector(0,0),false,nil,nil,DOTA_TEAM_GOODGUYS)
  end

  if s == "Create Unit to attack2" then
    ShuaGuai()
  end

  if s == "Create Unit to attack3" then
  	Timers:CreateTimer( 3.0, function()

  		ShuaGuai()

      return 3.0
    end
  )
  end

  if s == "MapAllView" then
    AddFOWViewer(2,Vector(0,0),100000.0,500.0,false)--天辉方单位在以坐标(0,0)半径1000.0范围内拥有全部视野，持续5秒
  end

end

function Ctest:InitGameMode()

--设置游戏准备时间
GameRules:SetPreGameTime( 3.0)

--监听游戏进度
--ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(Ctest,"OnGameRulesStateChange"), self)


ListenToGameEvent( "entity_killed", Dynamic_Wrap( Ctest, 'OnEntityKilled' ), self )

--確認一下是不是成功賭取
UTIL_MessageTextAll("Init Success",255,0,0,255)--BUG點:不能發nil，要"nil"要不然會崩潰

--監聽單位重生或者創建事件
ListenToGameEvent("npc_spawned", Dynamic_Wrap(Ctest, "OnNPCSpawned"), self)

--玩家死亡事件
--ListenToGameEvent("dota_player_killed",Death,nil)

--玩家選取事件
ListenToGameEvent("dota_player_pick_hero",Pick_Hero,nil)

--玩家對話事件
ListenToGameEvent("player_chat",Chat,nil)


end

function Ctest:OnEntityKilled( event )
  DeepPrintTable(event)    --详细打印传递进来的表
  print("@@@@ : Death Event Run")

  local killedUnit = EntIndexToHScript( event.entindex_killed )
  print("@@@  killed Unit = "..killedUnit:GetUnitName() )

  --print(event.entindex_killed, " killed")
  if killedUnit:IsRealHero() then
    print("@@@@ : YES , i am dead hero")

    --print("Hero has been killed")
    if killedUnit:IsReincarnating() == false then --是否處於重生狀態 (不懂? 是說死過一次還是單位還活著) END:效果為單位是否還活著
      print("@@@@ : Setting time for respawn")
      killedUnit:SetTimeUntilRespawn(killedUnit:GetLevel()*0.5)--設定復活時間
    end

  end
end


function Death(info)
  print("@@@@ : Death Event Run")
  DeepPrintTable(info)    --详细打印传递进来的表

  -- 储存被击杀的单位
  local killedUnit = EntIndexToHScript( info.entindex_killed )
  -- 储存杀手单位
  local killerEntity = EntIndexToHScript( info.entindex_attacker )

  --EntIndexToHScript handle EntIndexToHScript(int a) 把一个实体的整数索引转化为表达该实体脚本实例的HScript

  print("@@@  killed Unit = "..killedUnit:GetUnitName() )
  print("@@@  killer Unit = "..killerEntity:GetUnitName() )

end


function Activate()--此函數=初始化
end	

-- 在执行完这个文件，和我们上面所LoadModule之后，
-- dota2的build_slave的vlua.cpp就会开始执行addon_game_mode.lua

-- 这里我们只写一个内容，DOTA2XGameMode:初始化
Ctest:InitGameMode()

