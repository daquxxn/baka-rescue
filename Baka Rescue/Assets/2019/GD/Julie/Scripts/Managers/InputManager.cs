using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Zblah.Utils;

public class InputManager : Singleton<InputManager>
{
    #region Fields
    [SerializeField] private float _deadZone = 0.25f;
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

    private event Action<Vector3> _spellFire = null;
    public event Action<Vector3> SpellFire
    {
        add
        {
            _spellFire -= value;
            _spellFire += value;
        }
        remove
        {
            _spellFire -= value;
        }
    }

    private event Action<bool> _transFire = null;
    public event Action<bool> TransFire
    {
        add
        {
            _transFire -= value;
            _transFire += value;
        }
        remove
        {
            _transFire -= value;
        }
    }

    private event Action<bool> _transWater = null;
    public event Action<bool> TransWater
    {
        add
        {
            _transWater -= value;
            _transWater += value;
        }
        remove
        {
            _transWater -= value;
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
        

        if (_moveX1 != null)
        {
            _moveX1(Input.GetAxis("Horizontal"));
        }

        if (_moveX2 != null)
        {
            _moveX2(Input.GetAxis("Horizontal2"));
        }
    }

    private void GameLoop()
    {
        
        GetMouseInputs();
        GetKeyboardInputs();
        GetGamePadInputs();
    }

    private void GetMouseInputs()
    {

    }

    private void GetKeyboardInputs()
    {
       
    }

    private void GetGamePadInputs()
    {
       
      

        if (_onJumpKeyOne != null)
        {
            _onJumpKeyOne(Input.GetButtonDown("Jump"));
        }

        if (_onJumpKeyTwo != null)
        {
            _onJumpKeyTwo(Input.GetButtonDown("Jump2"));
        }

        

        if(_spellWater != null && Input.GetButtonDown("SpellWater"))
        {
            float rightAnalogH = Input.GetAxis("RightAnalogH2");
            float rightAnalogV = Input.GetAxis("RightAnalogV2");
            Vector3 dirSpell = new Vector3(rightAnalogH, -rightAnalogV, 0);
            if(dirSpell.magnitude < _deadZone)
            {
                dirSpell = Vector3.zero;
            }
            dirSpell.Normalize();
            _spellWater(dirSpell);
        }

        if (_spellFire != null && Input.GetButtonDown("SpellFire"))
        {
            float rightAnalogH = Input.GetAxis("RightAnalogH");
            float rightAnalogV = Input.GetAxis("RightAnalogV");
            Vector3 dirSpell = new Vector3(rightAnalogH, -rightAnalogV, 0);
            if(dirSpell.magnitude < _deadZone)
            {
                dirSpell = Vector3.zero;
            }
            dirSpell.Normalize();
            _spellFire(dirSpell);
        }

        if(_transFire != null)
        {
            _transFire(Input.GetButtonDown("TransfoFire"));
        }

        if (_transWater != null)
        {
            _transWater(Input.GetButtonDown("TransfoWater"));
        }

      
    }

    private void ResetInputs()
    {

    }
    #endregion Methods
}
