﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ElementalCharacter : AElement
{

    public override void ElementalReaction(EElement element)
    {
        switch (element)
        {
            case EElement.WATER:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when WATER touch FIRE surface
                  // _element = EElement.NONE;
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when WATER touch THUNDER surface
                    // pass de surface l'électricité
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when WATER touch WATER surface
                    // mouillé + lgts 
                }
                else if (_element == EElement.NONE)
                {
                   _element = EElement.WATER;
                }
                break;
            case EElement.THUNDER:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when THUNDER touch FIRE surface
                    // rien
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when THUNDER touch THUNDER surface
                    //stun + lgts
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when THUNDER touch WATER surface
                    //propagation de l'elec
                }
                else if (_element == EElement.NONE)
                {
                   _element = EElement.THUNDER;
                }
                break;
            case EElement.FIRE:
                if (_element == EElement.FIRE)
                {
                    // do whatever you want to do when FIRE touch FIRE surface
                    // mini explosion bonus apparence
                }
                else if (_element == EElement.THUNDER)
                {
                    // do whatever you want to do when FIRE touch THUNDER surface
                    //Rien
                }
                else if (_element == EElement.WATER)
                {
                    // do whatever you want to do when FIRE touch WATER surface
                    // l'éteind
                }
                else if (_element == EElement.NONE)
                {

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
            if (other is ElementalProjectile && tag != gameObject.tag)
                Destroy(other.gameObject);
        }
    }
}