using System.Collections;
using System.Collections.Generic;
using UnityEngine;


// Auto add Rigidbody component
[RequireComponent(typeof(Rigidbody))]
public class ElementalProjectile : AElement
{
    [SerializeField] private float _force = 2;

    private Vector3 _dir = Vector3.zero;
    private Rigidbody _rb = null;
    

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
    public void Init(Vector3 direction)
    {
        _rb = GetComponent<Rigidbody>();
        _dir = direction;
        _rb.AddForce(direction * _force);
    }

    private void OnDestroy()
    {
        // IF _element == EElement.WATER
        // -> INSTANTIATE ELEMENTALSURFACE WATER
    }
}
