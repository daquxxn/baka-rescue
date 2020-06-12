using System.Collections;
using System.Collections.Generic;
using UnityEngine;


// Auto add Rigidbody component
[RequireComponent(typeof(Rigidbody))]
public class ElementalProjectile : AElement
{
    [SerializeField] private float _force = 2;
    [SerializeField] private float _secs = 2;

    private Vector3 _dir = Vector3.zero;
    private Rigidbody _rb = null;

    [SerializeField] private ElementalSurface _elemSurface;
    private int _instanceID = 0;

    [SerializeField] private int _damages = 1;

    [SerializeField] private LayerMask _groundLayer = 0;

    public int Damages
    {
        get
        {
            return _damages;
        }
    }



    public int InstanceID
    {
        get
        {
            return _instanceID;
        }
    }

    private void Start()
    {
       
    }

    private void Update()
    {
      
    }

    public override void ElementalReaction(EElement element)
    {
        // For now, no need further implementation. Let it empty.
    }

    // Must be called by what instatiate projectile
    // Launch Projectile with AddForce
    // Can get more parameter life the projection force
    public void Init(Vector3 direction, int instanceID)
    {
         _instanceID = instanceID;
        _rb = GetComponent<Rigidbody>();
        _dir = direction;
        _rb.AddForce(direction * _force);
        Destroy(gameObject, _secs);

    }

    private void CreateSurface()
    {
        // IF _element == EElement.WATER
        // -> INSTANTIATE ELEMENTALSURFACE WATER

        if (_element != EElement.THUNDER)
        {
            RaycastHit hit;
            
            Physics.Raycast(transform.position + Vector3.up , Vector3.down, out hit, 5, _groundLayer);
            if(hit.collider != null)
            {
                Instantiate(_elemSurface, hit.point, Quaternion.identity);
            }
        }
    }


    

    private void OnTriggerEnter (Collider collision)
    {
        if(collision.gameObject.layer == 8)
        {
            CreateSurface();
            Destroy(gameObject);
        }
    if(collision.gameObject.layer == 15 && _element != EElement.WATER)
        {
            Destroy(gameObject);
        }
    if(collision.gameObject.layer == 16)
        {
            Destroy(gameObject);
        }
    
    }
}
