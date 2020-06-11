using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class CharacController : MonoBehaviour
{
    [Header("Movement")]
    [SerializeField] private int _speedCharac = 10;
    [SerializeField] private int _jumpForce = 0;
    private bool _isGrounded = false;
    [SerializeField] private float _rayDistance = 0;

    [Header("rb & trans")]
    [SerializeField] private Transform _charaTrans = null;
    [SerializeField] private Rigidbody _rb = null;
   
    [Header("Layers")]
    [SerializeField] private LayerMask _ground = 0;
    [SerializeField] private LayerMask _enemy = 0;
   
    [Header("which player?")]
    [SerializeField] private bool _isPlayerOne = true;
    
    [Header("invunerability")]
    [SerializeField] private bool _invulnerable = false;
    [SerializeField] private float _iTime = 1.5f;
    [SerializeField] private float _iCounter = 0;

    [Header("other scirpts")]
    [SerializeField] private CharacHealth _characHealth = null;

    [Header("element prefabs")]
    [SerializeField] private ElementalProjectile _thunderPrefab = null;
    [SerializeField] private ElementalProjectile _waterPrefab = null;

    [Header("container")]
    [SerializeField] private Transform _projectileContainer = null;

    [Header("stun")]
    private float _stunTimeStamp = 0f;
    [SerializeField] private float _stunDuration = 2f;
    [SerializeField] private GameObject _stunFX = null;
    [SerializeField] private GameObject _thunderSphere = null;

    private AudioSource _walkAudio;

    private bool _isStun = false;
    private bool _canMove = true;

    public bool CanMove
    {
        get
        { return _canMove; }
        set
        { _canMove = value; }
    }

    public void Stun()
    {
        if (_isPlayerOne == true)
        {
            InputManager.Instance.MoveX1 -= Move;
            InputManager.Instance.OnJumpKeyOne -= Jump;
            InputManager.Instance.SpellThunder -= SpellThunder;
            _stunFX.SetActive(true);
        }
        else
        {
            InputManager.Instance.MoveX2 -= Move;
            InputManager.Instance.OnJumpKeyTwo -= Jump;
            InputManager.Instance.SpellWater -= SpellWater;
            _stunFX.SetActive(true);
        }
        _isStun = true;
    }

    private void UnStun()
    {
        if (_isPlayerOne == true)
        {
            InputManager.Instance.MoveX1 += Move;
            InputManager.Instance.OnJumpKeyOne += Jump;
            InputManager.Instance.SpellThunder += SpellThunder;
            _stunFX.SetActive(false);
            _thunderSphere.SetActive(true);
        }
        else
        {
            InputManager.Instance.MoveX2 += Move;
            InputManager.Instance.OnJumpKeyTwo += Jump;
            InputManager.Instance.SpellWater += SpellWater;
            _stunFX.SetActive(false);
            _thunderSphere.SetActive(true);
        }
    }

    void Start()
    {
        GameLoopManager.Instance.GameLoop += GameLoop;
        PlayerManager.Instance.Charac = this;
        GetInputs();
        _rb = GetComponent<Rigidbody>();
        _canMove = true;
        _walkAudio = GetComponent<AudioSource>();
        _invulnerable = false;
    }

    private void OnDestroy()
    {
        GameLoopManager.Instance.GameLoop -= GameLoop;
        if (_isPlayerOne == true)
        {
            InputManager.Instance.MoveX1 -= Move;
            InputManager.Instance.OnJumpKeyOne -= Jump;
            InputManager.Instance.SpellThunder -= SpellThunder;
            InputManager.Instance.ShieldX1 -= ShieldX1;
        }
        else
        {
            InputManager.Instance.MoveX2 -= Move;
            InputManager.Instance.OnJumpKeyTwo -= Jump;
            InputManager.Instance.SpellWater -= SpellWater;
            InputManager.Instance.ShieldX2 -= ShieldX2;
        }
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

        if(_isStun)
        {
            _stunTimeStamp += Time.deltaTime;

            if(_stunTimeStamp >= _stunDuration)
            {
                _isStun = false;
                _stunTimeStamp = 0;
                UnStun();
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

        if (horizontalDir != 0 & _canMove)
        {
            newVelocity.x = horizontalDir * _speedCharac * Time.deltaTime;
            _charaTrans.transform.right = newDirection;
            _rb.velocity = newVelocity;
        }

        if(horizontalDir != 0 & _canMove & _isGrounded)
        {
         //   _walkAudio.Play();
        }
    }

    private void SpellThunder(Vector3 dirSpell)
    {
        ElementalProjectile elementalProjectile = Instantiate(_thunderPrefab, transform.position, Quaternion.identity, _projectileContainer);

        if(dirSpell != Vector3.zero)
        {
            elementalProjectile.Init(dirSpell, gameObject.GetInstanceID());
        }
       else
        {
            elementalProjectile.Init(transform.right, gameObject.GetInstanceID());
        }
    }

    private void SpellWater(Vector3 dirSpell)
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

    private void ShieldX1(bool shieldDir)
    {

    }

    private void ShieldX2(bool shieldDir)
    {

    }


    private void GetInputs()
    {
        if (_isPlayerOne == true)
        {
            InputManager.Instance.MoveX1 += Move;
            InputManager.Instance.OnJumpKeyOne += Jump;
            InputManager.Instance.SpellThunder += SpellThunder;
            InputManager.Instance.ShieldX1 += ShieldX1;
        }
        else
        {
            InputManager.Instance.MoveX2 += Move;
            InputManager.Instance.OnJumpKeyTwo += Jump;
            InputManager.Instance.SpellWater += SpellWater;
            InputManager.Instance.ShieldX2 += ShieldX2;
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
        ElementalProjectile elemProj = other.GetComponent<ElementalProjectile>();

        if(elemProj != null && elemProj.InstanceID != gameObject.GetInstanceID())
        {
            Destroy(other.gameObject);
        }

        if (other.gameObject.layer == 17)
        {
            DamageFireSurface dmgFire = other.GetComponent<DamageFireSurface>();
            
            if (dmgFire != null && _invulnerable == false)
            {
                _characHealth.TakeDamage(dmgFire.Damages);
                _invulnerable = true;
            }
        }

        if (other.gameObject.layer == 18)
        {
            ElementalProjectile elemProject = other.GetComponent<ElementalProjectile>();
            
            if (elemProject != null && _invulnerable == false)
            {
                _characHealth.TakeDamage(elemProject.Damages);
                _invulnerable = true;
            }
        }
    }

}
