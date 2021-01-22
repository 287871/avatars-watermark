--使用了An QQ 2926669800 的代码 --Lua交流群  1093993910
--李清照和左词测试--
--此lua为柒制作 Aimware 图片水印 --QID AIMWAREQI


--这里设置你自己QQ图片将会更新为QQ头像--
local qi_avatars_qq = "2878713023";
---------------------------------------
local version = "版本 1.1"
local version_url = "https://raw.githubusercontent.com/287871/avatars-watermark/main/VERSION.txt"
print("-------------------")
-- Update
http.Get(version_url, function(content)
	if version == string.gsub(content, "[\r\n]", "") then
		print("[头像水印] 最新版本")
	else
        local new_version = http.Get("https://raw.githubusercontent.com/287871/avatars-watermark/main/avatars-watermark%20-%20QQ.lua");
        local update_log = http.Get("https://raw.githubusercontent.com/287871/avatars-watermark/main/README.md");
        local old = file.Open(GetScriptName(), "w")
        old:Write(new_version)
        old:Close()
        print("[头像水印] 需要更新(重新加载即可)")
        print(update_log)
		UnloadScript(GetScriptName())
	end
end)
--
local X , Y = draw.GetScreenSize();
local qi_avatars_qq_ui_Checkbox = gui.Checkbox( gui.Reference( "Visuals" , "Local" , "Camera" ), "qi_avatars_qq_ui", "图片水印", 0 );
local sX_avatars_qq_ui = gui.Slider( gui.Reference( "Visuals" , "Local"  ), "qi_avatars_qq_ui_x", "X", 400 , 0 , X );
local sY_avatars_qq_ui = gui.Slider( gui.Reference( "Visuals" , "Local"  ), "qi_avatars_qq_ui_y", "Y", 70 , 0 , Y );
sX_avatars_qq_ui:SetInvisible( true );
sY_avatars_qq_ui:SetInvisible( true );

local is_inside = function(a, b, x, y, w, h) return a >= x and a <= w and b >= y and b <= h end
local tX, tY, offsetX, offsetY, _drag
local drag_menu = function(x, y, w, h)
    if not gui.Reference("MENU"):IsActive() then
        return tX, tY
    end

    local mouse_down = input.IsButtonDown(1)

    if mouse_down then
        local X, Y = input.GetMousePos()

        if not _drag then
            local w, h = x + w, y + h
            if is_inside(X, Y, x, y, w, h) then
                offsetX, offsetY = X - x, Y - y
                _drag = true
            end
        else
            tX, tY = X - offsetX, Y - offsetY
            sX_avatars_qq_ui:SetValue(tX) sY_avatars_qq_ui:SetValue(tY)
        end
    else
        _drag = false
    end

    return tX, tY
end
--
function gradientH(x1, y1, x2, y2,col1, left)
    local w = x2 - x1
    local h = y2 - y1
 
    for i = 0, w do
        local a = (i / w) * col1[4]
        local r, g, b = col1[1], col1[2], col1[3];
        draw.Color(r,g,b, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end
--
local avatars_qq_Get = http.Get("http://q1.qlogo.cn/g?b=qq&nk="..qi_avatars_qq.."&s=100&t=");
local RGBA, width, height = common.DecodeJPEG(avatars_qq_Get);
local texture = draw.CreateTexture(RGBA, width, height)
local font = draw.CreateFont('Verdana', 13.5, 11.5);
local font2 = draw.CreateFont('Verdana', 12, 11.5);
function drawavatars_qq()
    if not tX then
        tX, tY = sX_avatars_qq_ui:GetValue(),sY_avatars_qq_ui:GetValue()
    end
    local lp = entities.GetLocalPlayer();
    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50 , y + 50
    if qi_avatars_qq_ui_Checkbox:GetValue() then
    if lp ~= nil  then
    --信息栏
    --hp
    local localPlayer = entities.GetLocalPlayer()
    local hp = localPlayer:GetHealth()
    local r , g , b , a = 34, 34, 34, 255
    gradientH( x-130 , y , x , y-20 ,{ r , g , b , a*0.6 }, true);
    gradientH( x-125 , y , x , y-20 ,{ r , g , b , a*0.8 }, true);
    gradientH( x-120 , y , x , y-20 ,{ r , g , b , a }, true);
    gradientH( x-115 , y , x , y-20 ,{ r , g , b , a }, true);
    gradientH( x-112 , y , x , y-20 ,{ r , g , b , a }, true);
    gradientH( x-110 , y , x , y-20 ,{ r , g , b , a }, true);
    gradientH( x-108 , y , x , y-20 ,{ r , g , b , a }, true);
    gradientH( x-106 , y , x , y-20 ,{ r , g , b , a }, true);
    draw.SetFont( font2 )
    if hp > 35 then
    draw.Color( 134, 200, 134, 255 )
    else
    draw.Color( 255, 0, 0, 255 )    
    end
    draw.TextShadow( x-92, y-15, hp.."hp" )        
    --货币
    local Money = localPlayer:GetProp("m_iAccount")
    local r , g , b , a = 40, 40, 40, 255
    gradientH( x , y , x+170 , y+20 ,{ r , g , b , a*0.6  }, false);
    gradientH( x , y , x+165 , y+20 ,{ r , g , b , a*0.8  }, false);
    gradientH( x , y , x+165 , y+20 ,{ r , g , b , a  }, false);
    gradientH( x , y , x+160 , y+20 ,{ r , g , b , a  }, false);
    gradientH( x , y , x+155 , y+20 ,{ r , g , b , a  }, false);
    gradientH( x , y , x+152 , y+20 ,{ r , g , b , a  }, false);
    gradientH( x , y , x+150 , y+20 ,{ r , g , b , a  }, false);
    gradientH( x , y , x+148 , y+20 ,{ r , g , b , a  }, false);
    gradientH( x , y , x+146 , y+20 ,{ r , g , b , a  }, false);
    draw.Color( 254, 215, 0, 255 )
    draw.TextShadow( x+65, y+5, "Money ● " )
    draw.Color( 255, 255, 255, 255 )
    draw.TextShadow( x+110, y+5, "$"..Money )

    --绘制底色1
     --绘制底色1
    if hp > 35 then
     r , g , b , a = 134, 200, 134, 255
    else
     r , g , b , a = 255, 0, 0, 255   
    end

    local radius = 57.5
    local thickness = 10
    local ir, ig, ib, ia = r , g , b , a
    if thickness > radius then
        thickness = radius
    end

    local ang = (hp * -1)/2
    for steps = 11, 100 do

        local sin_cur = math.sin(math.rad(steps * 8 + 180))
        local sin_old = math.sin(math.rad(steps * 8 - 8 + 180))
        local cos_cur = math.cos(math.rad(steps * 8 + 180))
        local cos_old = math.cos(math.rad(steps * 8 - 8 + 180))
        local cur_point = nil;
        local old_point = nil;

        cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
        old_point = {x + sin_old * radius, y + cos_old * radius};

        local cur_point2 = nil;
        local old_point2 = nil;

        cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
        old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
        
        if steps >= ang - 1 and steps <= ang + 0.1 then
            draw.Color(14, 14, 14, 10)
        else
            draw.Color(14, 14, 14, 10)
        end
        if ang - 1 < 0 and steps >= 102 + (ang - 1) then
            draw.Color(ir, ig, ib, ia-200)
        end
        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
    end 
    local radius = 57
    local thickness = 4
    local ir, ig, ib, ia = r , g , b , a
    if thickness > radius then
        thickness = radius
    end

    local ang = (hp * -1)/2
    for steps = 11, 100 do

        local sin_cur = math.sin(math.rad(steps * 8 + 180))
        local sin_old = math.sin(math.rad(steps * 8 - 8 + 180))
        local cos_cur = math.cos(math.rad(steps * 8 + 180))
        local cos_old = math.cos(math.rad(steps * 8 - 8 + 180))
        local cur_point = nil;
        local old_point = nil;

        cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
        old_point = {x + sin_old * radius, y + cos_old * radius};

        local cur_point2 = nil;
        local old_point2 = nil;

        cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
        old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
        
        if steps >= ang - 1 and steps <= ang + 0.1 then
            draw.Color(14, 14, 14, 10)
        else
            draw.Color(14, 14, 14, 10)
        end
        if ang - 1 < 0 and steps >= 102 + (ang - 1) then
            draw.Color(ir, ig, ib, ia-10)
        end
        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
    end 
    local radius = 57.1
    local thickness = 4
    local ir, ig, ib, ia = r , g , b , a
    if thickness > radius then
        thickness = radius
    end

    local ang = (hp * -1)/2
    for steps = 11, 100 do

        local sin_cur = math.sin(math.rad(steps * 8 + 180))
        local sin_old = math.sin(math.rad(steps * 8 - 8 + 180))
        local cos_cur = math.cos(math.rad(steps * 8 + 180))
        local cos_old = math.cos(math.rad(steps * 8 - 8 + 180))
        local cur_point = nil;
        local old_point = nil;

        cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
        old_point = {x + sin_old * radius, y + cos_old * radius};

        local cur_point2 = nil;
        local old_point2 = nil;

        cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
        old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
        
        if steps >= ang - 1 and steps <= ang + 0.1 then
            draw.Color(14, 14, 14, 10)
        else
            draw.Color(14, 14, 14, 10)
        end
        if ang - 1 < 0 and steps >= 102 + (ang - 1) then
            draw.Color(ir, ig, ib, ia-50)
        end
        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
    end 
    local radius = 57.2
    local thickness = 5
    local ir, ig, ib, ia = r , g , b , a
    if thickness > radius then
        thickness = radius
    end

    local ang = (hp * -1)/2
    for steps = 11, 100 do

        local sin_cur = math.sin(math.rad(steps * 8 + 180))
        local sin_old = math.sin(math.rad(steps * 8 - 8 + 180))
        local cos_cur = math.cos(math.rad(steps * 8 + 180))
        local cos_old = math.cos(math.rad(steps * 8 - 8 + 180))
        local cur_point = nil;
        local old_point = nil;

        cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
        old_point = {x + sin_old * radius, y + cos_old * radius};

        local cur_point2 = nil;
        local old_point2 = nil;

        cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
        old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
        
        if steps >= ang - 1 and steps <= ang + 0.1 then
            draw.Color(14, 14, 14, 10)
        else
            draw.Color(14, 14, 14, 10)
        end
        if ang - 1 < 0 and steps >= 102 + (ang - 1) then
            draw.Color(ir, ig, ib, ia-100)
        end
        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
    end 
    local radius = 57.3
    local thickness = 10
    local ir, ig, ib, ia = r , g , b , a
    if thickness > radius then
        thickness = radius
    end

    local ang = (hp * -1)/2
    for steps = 11, 100 do

        local sin_cur = math.sin(math.rad(steps * 8 + 180))
        local sin_old = math.sin(math.rad(steps * 8 - 8 + 180))
        local cos_cur = math.cos(math.rad(steps * 8 + 180))
        local cos_old = math.cos(math.rad(steps * 8 - 8 + 180))
        local cur_point = nil;
        local old_point = nil;

        cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
        old_point = {x + sin_old * radius, y + cos_old * radius};

        local cur_point2 = nil;
        local old_point2 = nil;

        cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
        old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
        
        if steps >= ang - 1 and steps <= ang + 0.1 then
            draw.Color(14, 14, 14, 10)
        else
            draw.Color(14, 14, 14, 10)
        end
        if ang - 1 < 0 and steps >= 102 + (ang - 1) then
            draw.Color(ir, ig, ib, ia-150)
        end
        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
    end 

    --绘制底色2
    local r , g , b , a = 36, 36, 36, 255
    draw.Color( r , g , b, a )
    draw.FilledCircle( x, y, 55 )
    draw.Color( r , g , b, a*0.8 )
    draw.FilledCircle( x, y, 55.1 )
    draw.FilledCircle( x, y, 55.2 )
    draw.Color( r , g , b, a*0.6 )
    draw.FilledCircle( x, y, 55.3 )
    draw.FilledCircle( x, y, 55.4 )
    draw.FilledCircle( x, y, 55.5 )
    draw.Color( r , g , b, a*0.4 )
    draw.FilledCircle( x, y, 55.6 )
    draw.FilledCircle( x, y, 55.7 )
    draw.FilledCircle( x, y, 55.8 )
    draw.FilledCircle( x, y, 55.9 )
    draw.Color( r , g , b, a*0.2 )
    draw.FilledCircle( x, y, 56 )
    draw.FilledCircle( x, y, 56.1 )
    draw.FilledCircle( x, y, 56.2)
    --头像
    local r , g , b , a = 255, 255, 255, 255
    draw.Color(r , g , b , a)
    draw.SetTexture(texture)
    draw.FilledRect(x-39, y-39, width-60+x, height-62 +y)

    --号码牌
    local r , g , b , a = 80,163, 248, 50
    local teamnumber = lp:GetTeamNumber()
    draw.Color(r , g , b , a)
    draw.FilledCircle( x, y+37, 14)
    draw.Color(r , g , b , a*0.8)
    draw.FilledCircle( x, y+37, 14.1)
    draw.Color(r , g , b , a*0.6)
    draw.FilledCircle( x, y+37, 14.2)
    draw.FilledCircle( x, y+37, 14.3)
    draw.Color(r , g , b , a*0.4)
    draw.FilledCircle( x, y+37, 14.4)
    draw.FilledCircle( x, y+37, 14.5)
    draw.FilledCircle( x, y+37, 14.6)
    draw.Color(r , g , b , a*0.2)
    draw.FilledCircle( x, y+37, 14.7)
    draw.FilledCircle( x, y+37, 14.8)
    draw.FilledCircle( x, y+37, 14.9)
    draw.FilledCircle( x, y+37, 15)
    draw.Color(255 , 255 , 255 , 255)
    local x1 , y1 = draw.GetTextSize(teamnumber)
    draw.SetFont( font )
    draw.TextShadow( x-x1+2, y+27, teamnumber )

    --绘制底色3
    local r , g , b , a = 34,34, 34, 255
    draw.Color( r , g , b, a )
    draw.OutlinedCircle( x, y, 55 )
    draw.OutlinedCircle( x, y, 54.5 )
    draw.OutlinedCircle( x, y, 54 )
    draw.OutlinedCircle( x, y, 53.5 )
    draw.OutlinedCircle( x, y, 53 )
    draw.OutlinedCircle( x, y, 52.5 )
    draw.OutlinedCircle( x, y, 52 )
    draw.OutlinedCircle( x, y, 51.5 )
    draw.OutlinedCircle( x, y, 51 )
    draw.OutlinedCircle( x, y, 50.5 )
    draw.OutlinedCircle( x, y, 50 )
    draw.OutlinedCircle( x, y, 49.5 )
    draw.OutlinedCircle( x, y, 49 )
    draw.OutlinedCircle( x, y, 48.5 )
    draw.OutlinedCircle( x, y, 48 )
    draw.OutlinedCircle( x, y, 47.5 )
    draw.OutlinedCircle( x, y, 47 )
    draw.OutlinedCircle( x, y, 46.5 )
    draw.OutlinedCircle( x, y, 46 )
    draw.OutlinedCircle( x, y, 45.5 )
    draw.OutlinedCircle( x, y, 45 )
    draw.OutlinedCircle( x, y, 44.5 )
    draw.OutlinedCircle( x, y, 44 )
    draw.OutlinedCircle( x, y, 43.5 )
    draw.OutlinedCircle( x, y, 43 )
    draw.OutlinedCircle( x, y, 42.5 )
    draw.OutlinedCircle( x, y, 42 )
    draw.OutlinedCircle( x, y, 41.5 )
    draw.OutlinedCircle( x, y, 41 )
    draw.OutlinedCircle( x, y, 40.5 )
    draw.OutlinedCircle( x, y, 40 )
    draw.Color( r , g , b, a*0.8 )
    draw.OutlinedCircle( x, y, 39.9 )
    draw.Color( r , g , b, a*0.6 )
    draw.OutlinedCircle( x, y, 39.8 )
    draw.OutlinedCircle( x, y, 39.7 )
    draw.Color( r , g , b, a*0.4 )
    draw.OutlinedCircle( x, y, 39.6 )
    draw.OutlinedCircle( x, y, 39.5 )
    draw.OutlinedCircle( x, y, 39.4 )
    draw.Color( r , g , b, a*0.2 )
    draw.OutlinedCircle( x, y, 39.3 )
    draw.OutlinedCircle( x, y, 39.2 )
    draw.OutlinedCircle( x, y, 39.1 )
    draw.OutlinedCircle( x, y, 39 )
    local armor = localPlayer:GetProp("m_ArmorValue")

    local r , g , b , a = 80,163, 248, 255

       local radius = 42
       local thickness = 0.8
       local ir, ig, ib, ia = r , g , b , a
       if thickness > radius then
           thickness = radius
       end
   
       local ang = (armor * -1)/2
       for steps = 11, 100 do
   
           local sin_cur = math.sin(math.rad(steps * 8 + 360))
           local sin_old = math.sin(math.rad(steps * 8 - 8 + 360))
           local cos_cur = math.cos(math.rad(steps * 8 + 360))
           local cos_old = math.cos(math.rad(steps * 8 - 8 + 360))
           local cur_point = nil;
           local old_point = nil;
   
           cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
           old_point = {x + sin_old * radius, y + cos_old * radius};
   
           local cur_point2 = nil;
           local old_point2 = nil;
   
           cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
           old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
           
           if steps >= ang - 1 and steps <= ang + 0.1 then
               draw.Color(14, 14, 14, 10)
           else
               draw.Color(14, 14, 14, 10)
           end
           if ang - 1 < 0 and steps >= 102 + (ang - 1) then
               draw.Color(ir, ig, ib, ia-150)
           end
           draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
           draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
       end 
       local radius = 42.2
       local thickness = 0.8
       local ir, ig, ib, ia = r , g , b , a
       if thickness > radius then
           thickness = radius
       end
   
       local ang = (armor * -1)/2
       for steps = 11, 100 do
   
           local sin_cur = math.sin(math.rad(steps * 8 + 360))
           local sin_old = math.sin(math.rad(steps * 8 - 8 + 360))
           local cos_cur = math.cos(math.rad(steps * 8 + 360))
           local cos_old = math.cos(math.rad(steps * 8 - 8 + 360))
           local cur_point = nil;
           local old_point = nil;
   
           cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
           old_point = {x + sin_old * radius, y + cos_old * radius};
   
           local cur_point2 = nil;
           local old_point2 = nil;
   
           cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
           old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
           
           if steps >= ang - 1 and steps <= ang + 0.1 then
               draw.Color(14, 14, 14, 10)
           else
               draw.Color(14, 14, 14, 10)
           end
           if ang - 1 < 0 and steps >= 102 + (ang - 1) then
               draw.Color(ir, ig, ib, ia-150)
           end
           draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
           draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
       end 
       local radius = 42.5
       local thickness = 0.8
       local ir, ig, ib, ia = r , g , b , a
       if thickness > radius then
           thickness = radius
       end
   
       local ang = (armor * -1)/2
       for steps = 11, 100 do
   
           local sin_cur = math.sin(math.rad(steps * 8 + 360))
           local sin_old = math.sin(math.rad(steps * 8 - 8 + 360))
           local cos_cur = math.cos(math.rad(steps * 8 + 360))
           local cos_old = math.cos(math.rad(steps * 8 - 8 + 360))
           local cur_point = nil;
           local old_point = nil;
   
           cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
           old_point = {x + sin_old * radius, y + cos_old * radius};
   
           local cur_point2 = nil;
           local old_point2 = nil;
   
           cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
           old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
           
           if steps >= ang - 1 and steps <= ang + 0.1 then
               draw.Color(14, 14, 14, 10)
           else
               draw.Color(14, 14, 14, 10)
           end
           if ang - 1 < 0 and steps >= 102 + (ang - 1) then
               draw.Color(ir, ig, ib, ia-10)
           end
           draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
           draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
       end 
       local radius = 42.7
       local thickness = 0.8
       local ir, ig, ib, ia = r , g , b , a
       if thickness > radius then
           thickness = radius
       end
   
       local ang = (armor * -1)/2
       for steps = 11, 100 do
   
           local sin_cur = math.sin(math.rad(steps * 8 + 360))
           local sin_old = math.sin(math.rad(steps * 8 - 8 + 360))
           local cos_cur = math.cos(math.rad(steps * 8 + 360))
           local cos_old = math.cos(math.rad(steps * 8 - 8 + 360))
           local cur_point = nil;
           local old_point = nil;
   
           cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
           old_point = {x + sin_old * radius, y + cos_old * radius};
   
           local cur_point2 = nil;
           local old_point2 = nil;
   
           cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
           old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
           
           if steps >= ang - 1 and steps <= ang + 0.1 then
               draw.Color(14, 14, 14, 10)
           else
               draw.Color(14, 14, 14, 10)
           end
           if ang - 1 < 0 and steps >= 102 + (ang - 1) then
               draw.Color(ir, ig, ib, ia-100)
           end
           draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
           draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
       end 
       local radius = 42.7
       local thickness = 0.8
       local ir, ig, ib, ia = r , g , b , a
       if thickness > radius then
           thickness = radius
       end
   
       local ang = (armor * -1)/2
       for steps = 11, 100 do
   
           local sin_cur = math.sin(math.rad(steps * 8 + 360))
           local sin_old = math.sin(math.rad(steps * 8 - 8 + 360))
           local cos_cur = math.cos(math.rad(steps * 8 + 360))
           local cos_old = math.cos(math.rad(steps * 8 - 8 + 360))
           local cur_point = nil;
           local old_point = nil;
   
           cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
           old_point = {x + sin_old * radius, y + cos_old * radius};
   
           local cur_point2 = nil;
           local old_point2 = nil;
   
           cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
           old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
           
           if steps >= ang - 1 and steps <= ang + 0.1 then
               draw.Color(14, 14, 14, 10)
           else
               draw.Color(14, 14, 14, 10)
           end
           if ang - 1 < 0 and steps >= 102 + (ang - 1) then
               draw.Color(ir, ig, ib, ia-150)
           end
           draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
           draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
       end 
       local radius = 42.9
       local thickness = 0.8
       local ir, ig, ib, ia = r , g , b , a
       if thickness > radius then
           thickness = radius
       end
   
       local ang = (armor * -1)/2
       for steps = 11, 100 do
   
           local sin_cur = math.sin(math.rad(steps * 8 + 360))
           local sin_old = math.sin(math.rad(steps * 8 - 8 + 360))
           local cos_cur = math.cos(math.rad(steps * 8 + 360))
           local cos_old = math.cos(math.rad(steps * 8 - 8 + 360))
           local cur_point = nil;
           local old_point = nil;
   
           cur_point = {x + sin_cur * radius, y + cos_cur * radius};    
           old_point = {x + sin_old * radius, y + cos_old * radius};
   
           local cur_point2 = nil;
           local old_point2 = nil;
   
           cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)};    
           old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)};
           
           if steps >= ang - 1 and steps <= ang + 0.1 then
               draw.Color(14, 14, 14, 10)
           else
               draw.Color(14, 14, 14, 10)
           end
           if ang - 1 < 0 and steps >= 102 + (ang - 1) then
               draw.Color(ir, ig, ib, ia-150)
           end
           draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
           draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])      
       end 

    end
    end
end
local kills  = {}
local deaths = {}
 
local function KillDeathCount(event)
    if qi_avatars_qq_ui_Checkbox:GetValue() then
	local local_player = client.GetLocalPlayerIndex( );
	local INDEX_Attacker = client.GetPlayerIndexByUserID( event:GetInt( 'attacker' ) );
	local INDEX_Victim = client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) );
 
	if (event:GetName( ) == "client_disconnect") or (event:GetName( ) == "begin_new_match") then
		kills = {}
		deaths = {}
	end
 
	if event:GetName( ) == "player_death" then
		if INDEX_Attacker == local_player then
			kills[#kills + 1] = {};
		end
 
		if (INDEX_Victim == local_player) then
			deaths[#deaths + 1] = {};
		end
    end
end
end
function drawavatars_qq2()
    if not tX then
        tX, tY = sX_avatars_qq_ui:GetValue(),sY_avatars_qq_ui:GetValue()
    end
    local lp = entities.GetLocalPlayer();
    if qi_avatars_qq_ui_Checkbox:GetValue() then
    if lp ~= nil then
    if (engine.GetServerIP() == "loopback") then
        server = "localhost"
    elseif string.find(engine.GetServerIP(), "A") then
        server = "valve"
    else
        server = "unknown"
    end
    local x, y = drag_menu(tX, tY, 100, 100)
    local x, y = x + 50 , y + 50
    local r , g , b , a = 34, 34, 34, 255
    gradientH( x+42 , y-10 , x+230 , y-35 ,{ r , g , b , a*0.8 }, false);
    gradientH( x+42 , y-10 , x+225 , y-35 ,{ r , g , b , a*0.6 }, false);
    gradientH( x+42 , y-10 , x+220 , y-35 ,{ r , g , b , a }, false);
    gradientH( x+42 , y-10 , x+218 , y-35 ,{ r , g , b , a }, false);
    gradientH( x+42 , y-10 , x+216 , y-35 ,{ r , g , b , a }, false);
    gradientH( x+42 , y-10 , x+214 , y-35 ,{ r , g , b , a }, false);
    gradientH( x+42 , y-10 , x+212 , y-35 ,{ r , g , b , a }, false);
    draw.Color(255 , 255 , 255 , 255)
    draw.SetFont( font2 )
    draw.TextShadow( x+65, y-27, server.." ●  kills "..#kills.." deaths "..#deaths )
    end  
end
end
callbacks.Register( "Draw","drawavatars_qq",drawavatars_qq );
callbacks.Register( "Draw","drawavatars_qq2",drawavatars_qq2 );

