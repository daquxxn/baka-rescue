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

    private EElementalType _eType = EElementalType.NONE;

    #region Properties
    public EElementalType Etype
    {
        get
        {
            return _eType;
        }
        set
        {
            _eType = value;
            if (_eType==EElementalType.WATER)
            {

            }
            
        }
    }
    #endregion Properties

    // Start is called before the first frame update
    void Start()
    {
        GameLoopManager.Instance.GameLoop += GameLoop;
        PlayerManager.Instance.Charac = this;
        GetInputs();
    }

    // Update is called once per frame
    void GameLoop()
    {  /* Vector3 newVelocity = _rb.velocity;
        float moveHorizontal = Input.GetAxis("Horizontal");
        Vector3 newDirection = new Vector3(moveHorizontal, 0, 0);

        if (moveHorizontal != 0 )
        {
            newVelocity.x = moveHorizontal * _speedCharac * Time.deltaTime;
            _charaTrans.transform.right = newDirection;
        }
        

        RaycastHit raycastHit;

        _isGrounded = Physics.Raycast(transform.position, Vector3.down, out raycastHit, _rayDistance, _ground);

        if (_isGrounded && Input.GetButtonDown("Jump"))
        {
            Debug.Log("juju");
            newVelocity.y = _jumpForce;
        }
        if (newVelocity != Vector3.zero)
            _rb.velocity = newVelocity;*/
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

        newVelocity.x = horizontalDir * _speedCharac * Time.deltaTime;
      _charaTrans.transform.right = newDirection;
        
            _rb.velocity = newVelocity;
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
        }
    }
}
