//
//  LevelScene.swift
//  HexMatch
//
//  Created by Josh McKee on 1/28/16.
//  Copyright © 2016 Josh McKee. All rights reserved.
//

import SpriteKit
import SNZSpriteKitUI

class NewGameScene: SNZScene {
    
    var checkboxMobilePieces: SNZCheckButtonWidget?
    var checkboxEnemyPieces: SNZCheckButtonWidget?
    var checkboxSoundEffects: SNZCheckButtonWidget?
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        self.updateGui()
    }
    
    func updateGui() {
        self.removeAllChildren()
        self.widgets.removeAll()
        
        // Set background
        self.backgroundColor = UIColor(red: 0x69/255, green: 0x65/255, blue: 0x6f/255, alpha: 1.0)
        
        // Create primary header
        let header = SNZSceneHeaderWidget()
        header.caption = "Select Map"
        self.addWidget(header)
        
        
        var verticalOffset:CGFloat = self.frame.height - 120
        
        // Create and position level buttons
        for unlockedLevel in (GameState.instance!.unlockedLevels) {
            let levelButton = MergelButtonWidget()
            levelButton.position = CGPointMake(20,verticalOffset)
            levelButton.caption = LevelHelper.instance.getLevelHelperModeCaption(unlockedLevel)
            levelButton.bind("tap",{
                
                
                LevelHelper.instance.mode = unlockedLevel
                GameStateMachine.instance!.enterState(GameSceneRestartState.self)
                
                self.view?.presentScene(SceneHelper.instance.gameScene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Down, duration: 0.4))
            });
            self.addWidget(levelButton)
            
            verticalOffset -= 60
        }
        
        // Add the close button
        let closeButton = MergelButtonWidget(parentNode: self)
        closeButton.anchorPoint = CGPointMake(0,0)
        closeButton.caption = "Back"
        closeButton.bind("tap",{
            self.view?.presentScene(SceneHelper.instance.levelScene, transition: SKTransition.pushWithDirection(SKTransitionDirection.Down, duration: 0.4))
        });
        self.addWidget(closeButton)
        
        // Render the widgets
        self.renderWidgets()
    }
    
}