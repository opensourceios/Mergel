//
//  LevelScene.swift
//  HexMatch
//
//  Created by Josh McKee on 1/28/16.
//  Copyright © 2016 Josh McKee. All rights reserved.
//

import SpriteKit
import SNZSpriteKitUI

class LevelScene: SNZScene {
    
    var checkboxMobilePieces: SNZCheckButtonWidget?
    var checkboxEnemyPieces: SNZCheckButtonWidget?
    
    override func didMoveToView(view: SKView) {        
        self.updateGui()
    }
    
    func updateGui() {
        self.removeAllChildren()
        self.widgets.removeAll()
    
        // Set background
        self.backgroundColor = UIColor(red: 0x69/255, green: 0x65/255, blue: 0x6f/255, alpha: 1.0)
    
        // Create primary header
        let header = SNZSceneHeaderWidget()
        header.caption = "Select Map and Options"
        self.addWidget(header)
        
        
        var verticalOffset:CGFloat = self.frame.height - 100
        
        // Create and position level buttons
        for unlockedLevel in (GameState.instance!.unlockedLevels) {
            let levelButton = SNZButtonWidget()
            levelButton.position = CGPointMake(10,verticalOffset)
            levelButton.caption = LevelHelper.instance.getLevelHelperModeCaption(unlockedLevel)
            levelButton.bind("tap",{
                self.captureSettings()
                
                LevelHelper.instance.mode = unlockedLevel
                GameStateMachine.instance!.enterState(GameSceneRestartState.self)
                
                self.close()
            });
            self.addWidget(levelButton)
            
            verticalOffset -= 60
        }
        
        // Create and position option buttons
        
        verticalOffset = self.frame.height - 100
        
        self.checkboxMobilePieces = SNZCheckButtonWidget(parentNode: self)
        self.checkboxMobilePieces!.isChecked = GameState.instance!.getIntForKey("include_mobile_pieces", 1) == 1
        self.checkboxMobilePieces!.caption = "Mobile Pieces"
        self.checkboxMobilePieces!.position = CGPointMake(300,verticalOffset)
        self.checkboxMobilePieces!.checkedTexture = SKTexture(imageNamed: "checkboxChecked")
        self.checkboxMobilePieces!.uncheckedTexture = SKTexture(imageNamed: "checkboxUnchecked")
        self.addWidget(self.checkboxMobilePieces!)
        
        verticalOffset -= 60
        
        self.checkboxEnemyPieces = SNZCheckButtonWidget(parentNode: self)
        self.checkboxEnemyPieces!.isChecked = GameState.instance!.getIntForKey("include_enemy_pieces", 1) == 1
        self.checkboxEnemyPieces!.caption = "Enemy Pieces"
        self.checkboxEnemyPieces!.position = CGPointMake(300,verticalOffset)
        self.checkboxEnemyPieces!.checkedTexture = SKTexture(imageNamed: "checkboxChecked")
        self.checkboxEnemyPieces!.uncheckedTexture = SKTexture(imageNamed: "checkboxUnchecked")
        self.addWidget(self.checkboxEnemyPieces!)
        
        // Add the close button
        let closeButton = SNZButtonWidget(parentNode: self)
        closeButton.anchorPoint = CGPointMake(0,0)
        closeButton.caption = "Cancel"
        closeButton.bind("tap",{
            self.close()
        });
        self.addWidget(closeButton)
        
        // Render the widgets
        self.renderWidgets()
    }
    
    func captureSettings() {
        GameState.instance!.setIntForKey("include_mobile_pieces", self.checkboxMobilePieces!.isChecked ? 1 : 0 )
        GameState.instance!.setIntForKey("include_enemy_pieces", self.checkboxEnemyPieces!.isChecked ? 1 : 0 )
    }
    
    func close() {
        self.view?.presentScene(SceneHelper.instance.gameScene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Down, duration: 0.4))
    }
    
}