using System;
using System.Collections.Generic;
using UnityEngine;

public class CharacterController : MonoBehaviour
{
    #region Fields
    #region StateMachine
    private Dictionary<ECharacterState, ACharacterState> _characterStates = null;
    private ECharacterState _nextState = ECharacterState.IDLE;
    private ECharacterState _lastState = ECharacterState.IDLE;
    private ECharacterState _currentStateType = ECharacterState.IDLE;
    #endregion StateMachine

    #region Physics
    [Header("Physic")]
    [SerializeField] private Rigidbody _rb = null;
    [SerializeField] private LayerMask _groundLayer = 0;
    [Header("Speed")]
    [SerializeField] private float _jumpForce = 10f;
    [SerializeField] private float _walkSpeed = 100f;
    [SerializeField] private float _airControlForce = 100f;
    [SerializeField] private float _groundedThreshold = 1;
    [SerializeField] private float _steamUpSpeed = 100f;
    [SerializeField] private float _steamXSpeed = 100f;

    private bool _isGrounded = false;
    #endregion Physics

    #region Inputs
    private Vector3 _moveDir = Vector3.zero;
    #endregion Inputs

    [SerializeField] private bool _isPlayerOne = false;

    [SerializeField] private float _steamTime = 2f;

    [SerializeField] private ElementalProjectile _firePrefab = null;
    [SerializeField] private ElementalProjectile _waterPrefab = null;

    [SerializeField] private Transform _projectileContainer = null;
    
    #endregion Fields

    #region Properties
    #region StateMachine
    public ECharacterState CurrentStateType => _currentStateType;
    public ECharacterState NextState => _nextState;
    public ECharacterState LastState => _lastState;
    public ACharacterState CurrentState => _characterStates[_currentStateType];
    public Dictionary<ECharacterState, ACharacterState> GameStates => _characterStates;
    #endregion StateMachine

    #region Physics
    public Rigidbody RB => _rb;
    public bool IsGrounded => _isGrounded;
    #endregion Physics

    #region Inputs
    public Vector3 MoveDir => _moveDir;
    #endregion Inputs

    public bool IsPlayerOne => _isPlayerOne;
    public float SteamTime => _steamTime;

    #endregion Properties

    #region Methods
    #region Mono
    public void Start()
    {
        _characterStates = new Dictionary<ECharacterState, ACharacterState>();
        GameLoopManager.Instance.GameLoop += GameLoop;
        GameLoopManager.Instance.FixedGameLoop += FixedGameLoop;
       // PlayerManager.Instance.Controllers.Add(this);
        InitializeDictionary();
        ChangeState(ECharacterState.IDLE, true);
    }

    private void InitializeDictionary()
    {
        ACharacterState instance = new JumpState() as JumpState;
        instance.Initialize(ECharacterState.JUMP, this);
        _characterStates.Add(ECharacterState.JUMP, instance);

        instance = new IdleState() as IdleState;
        instance.Initialize(ECharacterState.IDLE, this);
        _characterStates.Add(ECharacterState.IDLE, instance);

        instance = new WalkState() as WalkState;
        instance.Initialize(ECharacterState.WALK, this);
        _characterStates.Add(ECharacterState.WALK, instance);

        instance = new FallState() as FallState;
        instance.Initialize(ECharacterState.FALL, this);
        _characterStates.Add(ECharacterState.FALL, instance);

        instance = new SteamState() as SteamState;
        instance.Initialize(ECharacterState.STEAM, this);
        _characterStates.Add(ECharacterState.STEAM, instance);

    }

    private void GameLoop()
    {
        _isGrounded = Physics.Raycast(transform.position, Vector3.down,
            _groundedThreshold, _groundLayer);

        Debug.Log(_isGrounded + gameObject.name);
       
        if (_isPlayerOne)
        {
            _moveDir = InputManager.Instance.MoveDir1;
            if (_moveDir.x > 0)
            {
                transform.forward = Vector3.forward;
            }
            if (_moveDir.x < 0)
            {
                transform.forward = Vector3.back;
            }
        }   
        else
        {
            _moveDir = InputManager.Instance.MoveDir2;
            if (_moveDir.x > 0)
            {
                transform.forward = Vector3.forward;
            }
            if (_moveDir.x < 0)
            {
                transform.forward = Vector3.back;
            }
        }

        //dans un ontrigger enter elem contraire ; si je suis dans mon elem : change state steam
        if(Input.GetKeyDown(KeyCode.Space))
            {
                TransformToSteam();
            }

    }

    private void FixedGameLoop()
    {
        CurrentState.UpdateState();
    }
    #endregion Mono

    #region StateMachine
    public void ChangeState(ECharacterState nextState, bool forceMode = false)
    {
        if (forceMode == false)
        {
            CurrentState.ExitState();
            _lastState = _currentStateType;
        }
        _currentStateType = nextState;
        CurrentState.EnterState();
        //Debug.Log("Transition from " + LastState + " to " + _currentStateType);
        //Debug.Log("From " + gameObject.name);
    }

    public void TransformToSteam()
    {
        ChangeState(ECharacterState.STEAM);
    }

    //A RECODER EN STATE MACHINE 

    public void SpellFire(Vector3 dirSpell)
    {
        ElementalProjectile elementalProjectile = Instantiate(_firePrefab, transform.position, Quaternion.identity, _projectileContainer);

        if (dirSpell != Vector3.zero)
        {
            elementalProjectile.Init(dirSpell, gameObject.GetInstanceID());
        }
        else
        {
            elementalProjectile.Init(transform.right, gameObject.GetInstanceID());
        }
    }

    //A RECODER EN STATE MACHINE 


    public void SpellWater(Vector3 dirSpell)
    {
        ElementalProjectile projectile = Instantiate(_waterPrefab, transform.position, Quaternion.identity, _projectileContainer);

        if (dirSpell != Vector3.zero)
        {
            projectile.Init(dirSpell, gameObject.GetInstanceID());
        }
        else
        {
            projectile.Init(transform.right, gameObject.GetInstanceID());
        }
    }

    #endregion StateMachine

    #region Physics
    public void Jump()
    {
        _rb.AddForce(Vector3.up * _jumpForce, ForceMode.Impulse);
        _isGrounded = false;
        
    }

    public void AirControl()
    {
        Vector3 airControlDir = Vector3.zero;
        airControlDir.x = _moveDir.x;
        _rb.AddForce(airControlDir * _airControlForce, ForceMode.Force);
        Vector3 clampedVelocity = _rb.velocity;
        clampedVelocity.x = Mathf.Clamp(clampedVelocity.x, -_walkSpeed * Time.deltaTime, _walkSpeed * Time.deltaTime);
        _rb.velocity = clampedVelocity;
    }

    public void Walk()
    {
        Vector3 newVelocity = _rb.velocity;
        newVelocity.x = _moveDir.x * _walkSpeed * Time.deltaTime;
        _rb.velocity = newVelocity;
    }

    public void SteamMove()
    {
        Vector3 newVelocity = _rb.velocity;
        newVelocity.y = _steamUpSpeed * Time.deltaTime;
        newVelocity.x = _moveDir.x * _steamXSpeed * Time.deltaTime;
        _rb.velocity = newVelocity;
    }
    #endregion Physics

    #region Inputs

    #endregion Inputs
    #endregion Methods
}
