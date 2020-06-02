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
    private string _tag = null;
    


    private void Start()
    {
       
    }

    public override void ElementalReaction(EElement element)
    {
        // For now, no need further implementation. Let it empty.
    }

    // Must be called by what instatiate projectile
    // Launch Projectile with AddForce
    // Can get more parameter life the projection force
    public void Init(Vector3 direction, string tag)
    {
        _tag = tag;
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
            Instantiate(_elemSurface, transform.position, Quaternion.identity);
            Destroy(gameObject, _secs);
        }
    }
    
    private void OnTriggerEnter (Collider collision)
    {
        if(collision.gameObject.layer == 8)
        {
            CreateSurface();
            Destroy(gameObject);
        }
    if(collision.gameObject.layer == 15)
        {
            Destroy(gameObject);
        }
    
    }
}
