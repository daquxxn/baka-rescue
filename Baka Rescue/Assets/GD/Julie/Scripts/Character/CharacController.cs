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
    [SerializeField] private LayerMask _enemy = 0;
    [Header("lol")]

    [SerializeField] private bool _isPlayerOne = true;
    
    
    [SerializeField] private bool _invulnerable = true;
    [SerializeField] private float _iTime = 1.5f;
    [SerializeField] private float _iCounter = 0;

    [SerializeField] private CharacHealth _characHealth = null;

    [SerializeField] private ElementalProjectile _thunderPrefab = null;
    [SerializeField] private ElementalProjectile _waterPrefab = null;

    [SerializeField] private Transform _projectileContainer = null;



    void Start()
    {
        GameLoopManager.Instance.GameLoop += GameLoop;
        PlayerManager.Instance.Charac = this;
        GetInputs();

    }

    void GameLoop()
    {
        if(_invulnerable)
        {
            _iCounter += Time.deltaTime;

            if(_iCounter >= _iTime)
            {
                _invulnerable = false;
                _iCounter = 0;
            }
        }
    }

    private void Jump(bool jumpNow)
    {
        Vector3 newVelocity = _rb.velocity;
        RaycastHit raycastHit;

        _isGrounded = Physics.Raycast(transform.position, Vector3.down, out raycastHit, _rayDistance, _ground);

        if (_isGrounded & jumpNow)
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

    private void SpellThunder(Vector3 dirSpell)
    {
        ElementalProjectile elementalProjectile = Instantiate(_thunderPrefab, transform.position, Quaternion.identity, _projectileContainer);

        if(dirSpell != Vector3.zero)
        {
            elementalProjectile.Init(dirSpell);
        }
       else
        {
            elementalProjectile.Init(transform.right);
        }
    }

    private void SpellWater(Vector3 dirSpell)
    {
        ElementalProjectile projectile = Instantiate(_waterPrefab, transform.position, Quaternion.identity, _projectileContainer);

        if (dirSpell != Vector3.zero)
        {
            projectile.Init(dirSpell);
        }
        else
        {
            projectile.Init(transform.right);
        }
    }


    private void GetInputs()
    {
        if (_isPlayerOne == true)
        {
            InputManager.Instance.MoveX1 += Move;
            InputManager.Instance.OnJumpKeyOne += Jump;
            InputManager.Instance.SpellThunder += SpellThunder;
        }
        else
        {
            InputManager.Instance.MoveX2 += Move;
            InputManager.Instance.OnJumpKeyTwo += Jump;
            InputManager.Instance.SpellWater += SpellWater;
        }
    }
    
   

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.layer == 12)
        {
            BaseEnemy baseEnemy = collision.gameObject.GetComponent<BaseEnemy>();
            if (baseEnemy != null && _invulnerable == false)
            {
                _characHealth.TakeDamage(baseEnemy.Damages);
                _invulnerable = true;
            }
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Collectible")
        {
            Collectibles collectibles = other.gameObject.GetComponent<Collectibles>();
            if(collectibles != null)
            {
                _characHealth.GetLifeBack(collectibles.LifeHealed);
                Destroy(other.gameObject);
            }
        }
    }

}
