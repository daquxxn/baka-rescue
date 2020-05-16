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
                    // Eteind le feu
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when WATER touch THUNDER surface
                    // propagation de l'elec
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when WATER touch WATER surface
                    // Bloc de glace ? 
                }
                break;
            case EElement.THUNDER:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when THUNDER touch FIRE surface
                    // Rien
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when THUNDER touch THUNDER surface
                    //rien
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when THUNDER touch WATER surface
                    //propagation de l'elec
                }
                break;
            case EElement.FIRE:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when FIRE touch FIRE surface
                    // rien
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when FIRE touch THUNDER surface
                    //Rien
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when FIRE touch WATER surface
                    // rien
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
