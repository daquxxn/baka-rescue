using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ElementalSurface : AElement
{
    public override void ElementalReaction(EElement element)
    {
        switch (element)
        {
            case EElement.WATER:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when WATER touch FIRE surface
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when WATER touch THUNDER surface
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when WATER touch WATER surface
                }
                break;
            case EElement.THUNDER:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when THUNDER touch FIRE surface
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when THUNDER touch THUNDER surface
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when THUNDER touch WATER surface
                }
                break;
            case EElement.FIRE:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when FIRE touch FIRE surface
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when FIRE touch THUNDER surface
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when FIRE touch WATER surface
                }
                break;
        }
    }

    private void OnTriggerEnter(Collider collider)
    {
        // Check if other is AElement
        AElement other = collider.GetComponent<AElement>();
        if (other != null)
        {
            // React with other's element
            ElementalReaction(other.Element);

            // Destroy other if it's a Projectile
            if (other is ElementalProjectile)
                Destroy(other.gameObject);
        }
    }
}
