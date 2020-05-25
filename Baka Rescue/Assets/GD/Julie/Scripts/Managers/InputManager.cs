using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Zblah.Utils;

public class InputManager : Singleton<InputManager>
{
    #region Fields
    #endregion Fields

    #region Properties
    #endregion Properties

    #region Events
    private event Action<float> _moveX1 = null;
    public event Action<float> MoveX1
    {
        add
        {
            _moveX1 -= value;
            _moveX1 += value;
        }
        remove
        {
            _moveX1 -= value;
        }
    }

    private event Action<bool> _shieldX1 = null;
    public event Action<bool> ShieldX1
    {
        add
        {
            _shieldX1 -= value;
            _shieldX1 += value;
        }
        remove
        {
            _shieldX1 -= value;
        }
    }

    private event Action<bool> _shieldX2 = null;
    public event Action<bool> ShieldX2
    {
        add
        {
            _shieldX2 -= value;
            _shieldX2 += value;
        }
        remove
        {
            _shieldX2 -= value;
        }
    }

    private event Action<float> _moveX2 = null;
    public event Action<float> MoveX2
    {
        add
        {
            _moveX2 -= value;
            _moveX2 += value;
        }
        remove
        {
            _moveX2 -= value;
        }
    }

    private event Action<bool> _onJumpKeyOne = null;
    public event Action<bool> OnJumpKeyOne
    {
        add
        {
            _onJumpKeyOne -= value;
            _onJumpKeyOne += value;
        }
        remove
        {
            _onJumpKeyOne -= value;
        }
    }

    private event Action<bool> _onJumpKeyTwo = null;
    public event Action<bool> OnJumpKeyTwo
    {
        add
        {
            _onJumpKeyTwo -= value;
            _onJumpKeyTwo += value;
        }
        remove
        {
            _onJumpKeyTwo -= value;
        }
    }

    private event Action<Vector3> _spellWater = null;
    public event Action<Vector3> SpellWater
    {
        add
        {
            _spellWater -= value;
            _spellWater += value;
        }
        remove
        {
            _spellWater -= value;
        }
    }

    private event Action<Vector3> _spellThunder = null;
    public event Action<Vector3> SpellThunder
    {
        add
        {
            _spellThunder -= value;
            _spellThunder += value;
        }
        remove
        {
            _spellThunder -= value;
        }
    }

    #endregion Events

    #region Methods
    protected override void Start()
    {
        base.Start();
        GameLoopManager.Instance.GameLoop += GameLoop;
        GameLoopManager.Instance.FixedGameLoop += FixedGameLoop;
    }

    protected override void OnDestroy()
    {
        base.OnDestroy();
        GameLoopManager.Instance.GameLoop -= GameLoop;
        GameLoopManager.Instance.FixedGameLoop -= FixedGameLoop;
    }

    private void FixedGameLoop()
    {
        ResetInputs();
    }

    private void GameLoop()
    {
        GetGamePadInputs();
        GetMouseInputs();
        GetKeyboardInputs();
    }

    private void GetMouseInputs()
    {

    }

    private void GetKeyboardInputs()
    {
       
    }

    private void GetGamePadInputs()
    {
       
        if (_moveX1 != null)
        {
            _moveX1(Input.GetAxis("Horizontal"));
        }
        
        if (_moveX2 != null)
        {
            _moveX2(Input.GetAxis("Horizontal2"));
        }

        if (_onJumpKeyOne != null)
        {
            _onJumpKeyOne(Input.GetButtonDown("Jump"));
        }

        if (_onJumpKeyTwo != null)
        {
            _onJumpKeyTwo(Input.GetButtonDown("Jump2"));
        }

        if(_shieldX1 != null)
        {
            _shieldX1(Input.GetButtonDown("Shield1"));
        }

        if (_shieldX2 != null)
        {
            _shieldX2(Input.GetButtonDown("Shield2"));
        }

        if(_spellWater != null && Input.GetButtonDown("SpellWater"))
        {
            float rightAnalogH = Input.GetAxis("RightAnalogH2");
            float rightAnalogV = Input.GetAxis("RightAnalogV2");
            Vector3 dirSpell = new Vector3(rightAnalogH, -rightAnalogV, 0);
            _spellWater(dirSpell);
        }

        if (_spellThunder != null && Input.GetButtonDown("SpellThunder"))
        {
            float rightAnalogH = Input.GetAxis("RightAnalogH");
            float rightAnalogV = Input.GetAxis("RightAnalogV");
            Vector3 dirSpell = new Vector3(rightAnalogH, -rightAnalogV, 0);
            _spellThunder(dirSpell);
        }

      
    }

    private void ResetInputs()
    {

    }
    #endregion Methods
}
