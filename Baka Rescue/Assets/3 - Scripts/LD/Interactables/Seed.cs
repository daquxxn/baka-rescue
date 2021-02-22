using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Seed : AElement
{

    private bool _isWatered = false;
    [SerializeField] private GameObject _seedPlateform1 = null;
    [SerializeField] private GameObject _seedPlateform2 = null;

    public override void ElementalReaction(EElement elementReceived)
    {
        if (elementReceived == EElement.WATER)
        {
            if (_element == EElement.NONE)
            {
                _isWatered = true;
                //animation plante
                _seedPlateform1.SetActive(true);
                _seedPlateform2.SetActive(true);
            }
        }
    }

    private void OnTriggerEnter(Collider collider)
    {
        AElement other = collider.GetComponent<AElement>();
        if (other != null)
        {
            ElementalReaction(other.Element);

            // Destroy other if it's a Projectile
            if (other is ElementalProjectile)
                Destroy(other.gameObject);
        }
    }
}