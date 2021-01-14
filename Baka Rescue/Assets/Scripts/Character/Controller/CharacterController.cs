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
    [SerializeField] private float _jumpForce = 100f;
    [SerializeField] private float _walkSpeed = 100f;
    [SerializeField] private float _airControlForce = 100f;
    [SerializeField] private float _groundedThreshold = 1;

    private bool _isGrounded = false;
    #endregion Physics

    #region Inputs
    private Vector3 _moveDir = Vector3.zero;
    #endregion Inputs
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
    #endregion Properties

    #region Methods
    #region Mono
    public void Start()
    {
        _characterStates = new Dictionary<ECharacterState, ACharacterState>();
        GameLoopManager.Instance.GameLoop += GameLoop;
        GameLoopManager.Instance.FixedGameLoop += FixedGameLoop;
      //  CharacterManager.Instance.Controllers.Add(this);
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

    }

    private void GameLoop()
    {
        _isGrounded = Physics.Raycast(transform.position, Vector3.down,
            _groundedThreshold, _groundLayer);
       // _moveDir = InputManager.Instance.MoveDir;
        if (_moveDir.x > 0)
        {
            transform.forward = Vector3.right;
        }
        if (_moveDir.x < 0)
        {
            transform.forward = Vector3.left;
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
        Debug.Log("Transition from " + LastState + " to " + _currentStateType);
        Debug.Log("From " + gameObject.name);
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
    #endregion Physics

    #region Inputs
    #endregion Inputs
    #endregion Methods
}
