local composer = require( "composer" )
 
local scene = composer.newScene()
 
local widget = require("widget")

----------------------------------------------------------------------------------------------------

local backBtn
local bg

----------------------------------------------------------------------------------------------------

local function onBackBtnRelease()
    composer.removeScene("upgrade")
    composer.removeScene("game")
    composer.gotoScene("game", "fade", 200)
    return true
end

broke = false

local function outOfMoney(event)
    if (score < 0) then
        broke = true
    elseif (score > 0) then
        broke = false
    end
end

outOfMoney()


function onAttackUpgradeRelease()
    if not broke then
        attack = attack + 1
        attackText.text = attack
        score = score-attackCost
        attackCost = attackCost * 1.2
        attackCostText.text = "COST: "..math.floor(attackCost)
        scoreText.text = score
    elseif broke then
        brokeText = display.newImage("broke.png")
        brokeText.x = display.contentCenterX
        brokeText.y = display.contentCenterY
        brokeText.height = 65
        brokeText.width = 504
    end
end

local function onDefenseUpgradeRelease()
    if not broke then
        defense = defense + 1
        defenseText.text = defense
        score = score-defenseCost
        defenseCost = defenseCost * 1.2
        defenseCostText.text = "COST: "..math.floor(defenseCost)
        scoreText.text = score
    elseif broke then
        brokeText = display.newImage("broke.png")
        brokeText.x = display.contentCenterX
        brokeText.y = display.contentCenterY
        brokeText.height = 65
        brokeText.width = 504
    end
end

local function onReproductiveUpgradeRelease()
    if not broke then
        reproductionstatValue = spawnTimeBlue
        spawnTimeBlue = spawnTimeBlue*0.1
        score = score - reproductionCost
        reproductionstatValueText.text = reproductionstatValue
        reproductionCost = reproductionCost * 1.3
        reproductionCostText.text = "COST: "..math.floor(reproductionCost)
        spawnTimeBlue = spawnTimeBlue*0.9
        scoreText.text = score
    elseif broke then
        brokeText = display.newImage("broke.png")
        brokeText.x = display.contentCenterX
        brokeText.y = display.contentCenterY
        brokeText.height = 65
        brokeText.width = 504
    end
end

----------------------------------------------------------------------------------------------------

function scene:create( event )
 
    local sceneGroup = self.view
    
    backBtn = widget.newButton {
        defaultFile = "backbtn.png",
        height = 80, width = 220,
        onRelease = onBackBtnRelease
    }

    backBtn.x = 150
    backBtn.y = 100


    offset = 150
    upgradeX = display.contentCenterX - offset
    upgradeH = 50
    upgradeW = 220

    attackUpgrade = widget.newButton {
        defaultFile = "upgradebtn.png",
        height = upgradeH, width = upgradeW,
        onRelease = onAttackUpgradeRelease
    }

    attackUpgrade.x = upgradeX
    attackUpgrade.y = display.contentHeight/4 + offset

    defenseUpgrade = widget.newButton {
        defaultFile = "upgradebtn.png",
        height = upgradeH, width = upgradeW,
        onRelease = onDefenseUpgradeRelease
    }

    defenseUpgrade.x = upgradeX
    defenseUpgrade.y = display.contentHeight/2 + offset

    reproductionUpgrade = widget.newButton {
        defaultFile = "upgradebtn.png",
        height = upgradeH, width = upgradeW,
        onRelease = onReproductiveUpgradeRelease
    }

    reproductionUpgrade.x = upgradeX
    reproductionUpgrade.y = display.contentHeight/1.3 + offset

----------------------------------------------------------------------------------------------------

    bg = display.newImage("gamebackground.png")
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    bg.width = display.contentWidth
    bg.height = display.contentHeight

    attackstat = display.newImage("attackstat.png")
    attackstat.x = 556/4 + 100
    attackstat.y = display.contentHeight/4
    attackstat.width = 556/2
    attackstat.height = 168/2
    attackText = display.newText(attack, display.contentWidth - 100, display.contentHeight/4, "Aspergit", 84)
    attackCost = 25
    attackCostText = display.newText("COST "..attackCost, display.contentCenterX + offset, display.contentHeight/4 + offset, "Aspergit", 45)

    line1 = display.newImage("line.png")
    line1.x = display.contentCenterX
    line1.y = display.contentHeight/4 + 300
    line1.width = display.contentWidth - 100
    line1.height = 8

    defensestat = display.newImage("defensestat.png")
    defensestat.x = 644/4 + 100
    defensestat.y = display.contentHeight/2
    defensestat.width = 644/2
    defensestat.height = 168/2
    defenseText = display.newText(defense, display.contentWidth - 100, display.contentHeight/2, "Aspergit", 84)
    defenseCost = 25
    defenseCostText = display.newText("COST "..defenseCost, display.contentCenterX + offset, display.contentHeight/2 + offset, "Aspergit", 45)

    line2 = display.newImage("line.png")
    line2.x = display.contentCenterX
    line2.y = display.contentHeight/2 + 300
    line2.width = display.contentWidth - 100
    line2.height = 8

    reproductionstat = display.newImage("reproductionstat.png")
    reproductionstat.x = 1132/4 + 100
    reproductionstat.y = display.contentHeight/1.3
    reproductionstat.width = 1132/2
    reproductionstat.height = 168/2
    reproductionstatValue = spawnTimeBlue
    reproductionstatValueText = display.newText((spawnTimeBlue/1000).."s", display.contentWidth - 100, display.contentHeight/1.3, "Aspergit", 84)
    reproductionCost = 10
    reproductionCostText = display.newText("COST "..reproductionCost, display.contentCenterX + 145, display.contentHeight/1.3 + offset, "Aspergit", 45)

    scoreText = display.newText(score, display.contentWidth - 100, 100, "Aspergit", 84)

----------------------------------------------------------------------------------------------------

    sceneGroup:insert(bg)
    sceneGroup:insert(backBtn)
    sceneGroup:insert(attackstat)
    sceneGroup:insert(defensestat)
    sceneGroup:insert(reproductionstat)
    sceneGroup:insert(line1)
    sceneGroup:insert(line2)
    sceneGroup:insert(scoreText)
    sceneGroup:insert(attackText)
    sceneGroup:insert(defenseText)
    sceneGroup:insert(reproductionstatValueText)
    sceneGroup:insert(attackUpgrade)
    sceneGroup:insert(defenseUpgrade)
    sceneGroup:insert(reproductionUpgrade)
    sceneGroup:insert(reproductionCostText)
    sceneGroup:insert(attackCostText)
    sceneGroup:insert(defenseCostText)
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    if backBtn then
        backBtn:removeSelf()
        backBtn = nil
    end

    if attackUpgrade then
        attackUpgrade:removeSelf()
        attackUpgrade = nil
    end

    if defenseUpgrade then
        defenseUpgrade:removeSelf()
        defenseUpgrade = nil
    end

    if reproductionUpgrade then
        reproductionUpgrade:removeSelf()
        reproductionUpgrade = nil
    end
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene