using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Zblah.Utils;

public class InputManager : Singleton<InputManager>
{
    #region Fields
    [SerializeField] private float _deadZone = 0.25f;
    private Vector3 _moveDir1 = Vector3.zero;
    private Vector3 _moveDir2 = Vector3.zero;
    #endregion Fields

    #region Properties
    //normalized = touche le joystick marche direct
    public Vector3 MoveDir1 => _moveDir1.normalized;
    public Vector3 MoveDir2 => _moveDir2.normalized;
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

    private event Action _onJumpKeyOne = null;
    public event Action OnJumpKeyOne
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

    private event Action _onJumpKeyTwo = null;
    public event Action OnJumpKeyTwo
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

        _moveDir1.x = Input.GetAxis("Horizontal1");
        //_moveDir1.y = Input.GetAxis("Vertical1");
        _moveDir2.x = Input.GetAxis("Horizontal2");
        //_moveDir2.y = Input.GetAxis("Vertical2");

        if (Input.GetButtonDown("Jump"))
        {
            if(_onJumpKeyOne != null)
            _onJumpKeyOne();

        }

        if (Input.GetButtonDown("Jump2"))
        {
            if(_onJumpKeyTwo != null)
            _onJumpKeyTwo();
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
