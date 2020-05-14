using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class CharacController : MonoBehaviour
{
    [SerializeField] private int _speedCharac = 10;
    [SerializeField] private Transform _charaTrans = null;
    [SerializeField] private Rigidbody _rb = null;
    [SerializeField] private int _jumpForce = 0;
    private bool _isGrounded = false;
    [SerializeField] private float _rayDistance = 0;
    [SerializeField] private LayerMask _ground = 0;

    [SerializeField] private bool _isPlayerOne = true;

    [SerializeField] private int _maxHealth = 100;
    [SerializeField] private int _currentHealth;

    [SerializeField] private Healthbar _healthBar = null;

    [SerializeField] private int _damageTaken = 20;
    


    public int CurrentHealth
    {
        get
        { return _currentHealth; }
        set
        { _currentHealth = value; }
    }

    public int MaxHealth
    {
        get
        { return _maxHealth; }
        set
        { _maxHealth = value; }
    }

    private EElement _eType = EElement.NONE;

    #region Properties
    public EElement Etype
    {
        get
        {
            return _eType;
        }
        set
        {
            _eType = value;
            if (_eType == EElement.WATER)
            {

            }

        }
    }
    #endregion Properties

    void Start()
    {
        GameLoopManager.Instance.GameLoop += GameLoop;
        PlayerManager.Instance.Charac = this;
        GetInputs();

        _currentHealth = _maxHealth;
        _healthBar.SetMaxHealth(_maxHealth);
    }

    void GameLoop()
    {

    }

    private void Jump(bool jumpDir)
    {
        Vector3 newVelocity = _rb.velocity;
        RaycastHit raycastHit;

        _isGrounded = Physics.Raycast(transform.position, Vector3.down, out raycastHit, _rayDistance, _ground);

        if (_isGrounded & jumpDir)
        {
            newVelocity.y = _jumpForce;
        }
        if (newVelocity != Vector3.zero)
            _rb.velocity = newVelocity;
    }

    private void Move(float horizontalDir)
    {
        Vector3 newVelocity = _rb.velocity;
        Vector3 newDirection = new Vector3(horizontalDir, 0, 0);

        if (horizontalDir != 0)
        {
            newVelocity.x = horizontalDir * _speedCharac * Time.deltaTime;
            _charaTrans.transform.right = newDirection;
            _rb.velocity = newVelocity;
        }
    }


    private void GetInputs()
    {
        if (_isPlayerOne == true)
        {
            InputManager.Instance.MoveX1 += Move;
            InputManager.Instance.OnJumpKeyOne += Jump;
        }
        else
        {
            InputManager.Instance.MoveX2 += Move;
            InputManager.Instance.OnJumpKeyTwo += Jump;
        }
    }
    
    bool invulnerable = false;
    float iTime = 1.5f;
    float iCounter = 0;

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.layer == 12 && !invulnerable)
        {
            TakeDamage(_damageTaken);
            invulnerable = true;
        }
        /* if (invulnerable == true)
         {
             iCounter += Time.deltaTime;
             if (iCounter >= iTime)
             {
                 iTime = 0;
                 invulnerable = false;
             }
         }*/
    }

    private void TakeDamage(int damage)
    {
        _currentHealth -= damage;
        _healthBar.SetHealth(_currentHealth);
    }
}
