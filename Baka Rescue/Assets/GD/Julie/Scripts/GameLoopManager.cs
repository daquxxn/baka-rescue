using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Zblah.Utils;

public class GameLoopManager : Singleton<GameLoopManager>
{
    #region Events
    private Action _gameLoop = null;

    public event Action GameLoop
    {
        add
        {
            _gameLoop -= value;
           _gameLoop += value;
        }
        remove
        {
            _gameLoop -= value;
        }
    }
    private Action _secondGameLoop = null;

    public event Action SecondGameLoop
    {
        add
        {
            _secondGameLoop -= value;
            _secondGameLoop += value;
        }
        remove
        {
            _secondGameLoop -= value;
        }
    }

    private Action _fixedGameLoop;

    public event Action FixedGameLoop
    {
        add
        {
            _fixedGameLoop -= value;
            _fixedGameLoop += value;
        }
        remove
        {
            _fixedGameLoop -= value;
        }
    }

    private Action _lateGameLoop;

    public event Action LateGameLoop
    {
        add
        {
            _lateGameLoop -= value;
            _lateGameLoop += value;
        }
        remove
        {
            _lateGameLoop -= value;
        }
    }
    #endregion Events

    #region Methods
    protected override void Start()
    {
        base.Start();
    }
    #region Loop
    new private void Update()
    {
        if (_gameLoop != null)
            _gameLoop();

        if (_secondGameLoop != null)
            _secondGameLoop();
    }

    private void FixedUpdate()
    {
        if (_fixedGameLoop != null)
            _fixedGameLoop();
    }

    new private void LateUpdate()
    {
        if (_lateGameLoop != null)
            _lateGameLoop();
    }
    #endregion Loop
    #endregion Methods

}
