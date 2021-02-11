using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BurnVege : AElement
{

    private bool _isBurning = false;

    public override void ElementalReaction(EElement elementReceived)
    {
        if (elementReceived == EElement.FIRE)
        {
            if (_element == EElement.NONE)
            {
                    _isBurning = true;
                    Destroy(gameObject);
            }
        }
    }

    private void OnTriggerEnter(Collider collider)
    {
        AElement other = collider.GetComponent<AElement>();
        if (other != null )
        {
            ElementalReaction(other.Element);

            // Destroy other if it's a Projectile
            if (other is ElementalProjectile)
                Destroy(other.gameObject);
        }
    }
}
